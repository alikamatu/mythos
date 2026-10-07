import 'package:flutter/material.dart';

class Deity {
  final String id;
  final String name;
  final String greekName;
  final String title;
  final String domain;
  final String sacredSymbol;
  final String romanName;
  final String quote;
  final String lore;
  final Color primaryColor;
  final Color accentColor;
  final String iconKey;

  const Deity({
    required this.id,
    required this.name,
    required this.greekName,
    required this.title,
    required this.domain,
    required this.sacredSymbol,
    required this.romanName,
    required this.quote,
    required this.lore,
    required this.primaryColor,
    required this.accentColor,
    required this.iconKey,
  });
}

class MythStory {
  final String id;
  final String title;
  final String greekTitle;
  final String subtitle;
  final String epoch;
  final int readMinutes;
  final int audioMinutes;
  final String narrator;
  final List<String> tags;
  final String category;
  final String excerpt;
  final String fullText;
  final Color highlightColor;
  final String emblemKey;
  final String trialQuestion;
  final List<String> trialOptions;
  final int correctOptionIndex;

  const MythStory({
    required this.id,
    required this.title,
    required this.greekTitle,
    required this.subtitle,
    required this.epoch,
    required this.readMinutes,
    required this.audioMinutes,
    required this.narrator,
    required this.tags,
    required this.category,
    required this.excerpt,
    required this.fullText,
    required this.highlightColor,
    required this.emblemKey,
    required this.trialQuestion,
    required this.trialOptions,
    required this.correctOptionIndex,
  });
}

class DelphiWisdom {
  final String quote;
  final String greekText;
  final String attribution;
  final String temple;
  final String contemplation;

  const DelphiWisdom({
    required this.quote,
    required this.greekText,
    required this.attribution,
    required this.temple,
    required this.contemplation,
  });
}

class ArtifactRelic {
  final String name;
  final String greekName;
  final String craftsmaster;
  final String bearer;
  final String powerDescription;
  final String mythicLore;
  final String iconKey;

  const ArtifactRelic({
    required this.name,
    required this.greekName,
    required this.craftsmaster,
    required this.bearer,
    required this.powerDescription,
    required this.mythicLore,
    required this.iconKey,
  });
}
