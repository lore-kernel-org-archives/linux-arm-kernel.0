From: wellsk40@gmail.com (Kevin Wells)
Date: Tue, 26 Jan 2010 15:58:22 -0800
Subject: [PATCH 00/10] ARM: LPC32XX: New architecture support
Message-ID: <1264550302.6528.2@usb10132>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds support for the LPC32XX processor and includes
updates and fixes from review comments based on the previous RFC posts
from late November (thanks to everyone that reviewed and offered
feedback and suggestions).

This also adds full power and event management.

The previous i2c-pnx and pnx4008-wdt changes submitted by RK are
required to build a system based on these patches.

I would like inclusion into the Linux source tree with this code and
will start rolling in the other support drivers (net, RTC, TS, etc)
in later patches.

Patch summary
[PATCH 01/10] ARM: LPC32XX: Changes to existing files to support the  
LPC32XX architecture
[PATCH 02/10] ARM: LPC32XX: arch Kconfig, platform Kconfig, and  
makefiles
[PATCH 03/10] ARM: LPC32XX: core architecture files
[PATCH 04/10] ARM: LPC32XX: common architecture functions and structures
[PATCH 05/10] ARM: LPC32XX: clock tree support
[PATCH 06/10] ARM: LPC32XX: power and event management
[PATCH 07/10] ARM: LPC32XX: Phytec PHY3250 platform support file
[PATCH 08/10] ARM: LPC32XX: uncompress output and printascii() output  
functions
[PATCH 09/10] ARM: LPC32XX: architecture header files
[PATCH 10/10] ARM: LPC32XX: Phytec PHY3250 default kernel config

thanks,
Kevin Wells
NXP Semiconductors
