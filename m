From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:01:52 +0100
Subject: [PATCH 0/9] ARM: randconfig testing fallout
Message-ID: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some new patches that I've collected as part of the randconfig
testing. I don't think any of these are urgent, but it would be nice
to get them merged to cut down on the noise in randconfig testing.

The NR_IPIS patch is the only one that I expect to matter to real
users, but I think it's been broken for several years without anyone
noticing.

	Arnd
