From: apatard@mandriva.com (apatard at mandriva.com)
Date: Sat, 15 May 2010 17:29:58 +0200
Subject: [patch 0/6] kirkwood openrd client audio support - v2
Message-ID: <20100515152958.899927802@mandriva.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ added forgotten linux-arm-kernel cc: ]

Hi,

It's a new try to get merged support for openrd client audio.
I've tried to fix all comments, I hope I didn't miss something.

In the changes, there's :
- s/kirkwood/orion/
- Added a comment about data centered around 0 in the new control entry
- fixed quilt diffstat header braindamage
- added dapm support to cs42l51 codec
- use ASoC register cache support
- modified i2s driver to be a platform driver and move resource stuff to
  the right place


Arnaud Patard
