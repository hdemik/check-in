describe("App", function() {
  it("Is instantiated as vue", function() {
    expect(app._isVue).toBe(true);
  });

  it("has a default question", () => {
    // figure out why this got mounted...
    expect(app.question).toBe('…');
  });

  it("has a method for loading a question", async function() {
    var res = await app.loadQuestion();
    expect(app.question).not.toBe('...');
  });
});