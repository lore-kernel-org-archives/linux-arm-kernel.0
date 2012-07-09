From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Mon,  9 Jul 2012 21:39:11 +0200
Subject: Add basic device tree support for i.MX31 (and for a machine using it)
Message-ID: <1341862753-14848-1-git-send-email-GNUtoo@no-log.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following two patches add very basic device tree support for
 the i.MX31 and the buglabs's bug 1.x machine.

The i.MX31 patch was only tested on the buglabs bug 1.x because
  I only have two almost identical(the only difference is 
  that the one(the 1.3 version) has a libertas_sdio compatible 
  wifi+bluetooth chip) bug 1.x as i.MX31 machine.

Because of that only the uart5 was tested.

Denis.
