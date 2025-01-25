enum MarvelSection {
  home,
  heroes,
  villains,
  universe,
  events,
}

String getSectionName(MarvelSection section) {
  switch (section) {
    case MarvelSection.home:
      return 'HOME';
    case MarvelSection.heroes:
      return 'HEROES';
    case MarvelSection.villains:
      return 'VILLAINS';
    case MarvelSection.universe:
      return 'UNIVERSE';
    case MarvelSection.events:
      return 'EVENTS';
  }
}
