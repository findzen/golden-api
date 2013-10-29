#!/bin/bash

answer() {
  echo $GO
  say $GO -v Alex
}

echo 'Gold Room?'
GO= curl -s golden-api.herokuapp.com?text=1 | answer
