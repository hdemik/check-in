describe("App", function() {
  it("Is instantiated as vue", function() {
    expect(app._isVue).toBe(true);
  });

  it("has a default question", () => {
    expect(app.question).toBe('...');
  });

  it("has a method for loading a question", async function() {
    var res = await app.loadToday();
    expect(app.question).not.toBe('...');
  });
});