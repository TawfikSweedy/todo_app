import 'package:flutter/material.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsChangeNavigationTapState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsShowIndicatorState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessFalireState extends NewsStates
{
  final String error;

  NewsGetBusinessFalireState({required this.error});
}