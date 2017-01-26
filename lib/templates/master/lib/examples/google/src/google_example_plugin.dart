part of google_example;

class GoogleExamplePlugin extends AbstractRdPlugin {
  int sorting;
  GoogleExamplePlugin(this.sorting) : super(910) {}

  @override
  void configureScreens() {
    addScreen(GoogleExampleScreenIDs.GOOGLE_EXAMPLE, () => new GoogleExample(GoogleExampleScreenIDs.GOOGLE_EXAMPLE),
        transition: EffectIDs.DEFAULT, tree_order: sorting);
    addScreen(GoogleExampleScreenIDs.GOOGLE_FRIENDS, () => new GoogleFriends(GoogleExampleScreenIDs.GOOGLE_FRIENDS),
        transition: EffectIDs.DEFAULT, tree_parent: -2);
  }
}
