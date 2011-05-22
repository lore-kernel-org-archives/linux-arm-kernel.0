From: green@linuxhacker.ru (green at linuxhacker.ru)
Date: Sun, 22 May 2011 17:04:33 -0400
Subject: Initial B&N Nook Color support, take four
Message-ID: <1306098276-21112-1-git-send-email-green@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

  Next attempt at B&N Nook Color board file submission.
  USB peripheral mode is fully operational as is serial console and
  MMC/SDCard.

  Changes
  since v3:
  Separated mach-types change into a separate patch (already got RMK approval)
  Dramatically cut number of includes in the board file again.
  No longer set voltage regulator dev, just device name in the supply.
  Style fixes
  Serial in uncompress.h sorted by name
  Corrected MUX package to CBP in board file.
  omap_i2c_init now has no return since it's unused anyway.
  Fixed keypad definition.

  since v2:
  rebased on devel-cleanup branch

  since v1:
  Threw away all the android stuff as suggested 
  Cleaned up voltage regulators and removed the ones our twl chip actually
    does not have
  Changed the split of the patches to board file + twl update

Bye,
   Oleg
