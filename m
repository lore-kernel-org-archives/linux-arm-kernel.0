From: ada@thorsis.com (Alexander Dahl)
Date: Tue, 25 Jul 2017 14:00:21 +0200
Subject: [PATCH 0/3] memory: atmel-ebi: Fix setting EBI timings through dts
Message-ID: <1500984024-26403-1-git-send-email-ada@thorsis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this small patch series based on v4.13-rc2 fixes three things I found
when trying to run the latest rc on an at91samg20 based platform with
a SRAM like memory connected to the EBI interface, for which the
timings should be set through dts. 

For all register settings of interest I checked the hardware manuals
of the at91sam9g20 and the sama5d3x to not cause regressions, as well
as the actual register settings in the running system. (I used the
devmem tool from busybox for that.)

Greets
Alex
