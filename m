From: poggi.raph@gmail.com (=?UTF-8?Q?Rapha=C3=ABl_Poggi?=)
Date: Mon, 1 Sep 2014 11:44:08 +0200
Subject: arm: at91: sama5d3 suspend in ram
Message-ID: <CACqcpZCQ52p70SckWU-43ue6v-3Uekq4xC=kg=jYuc0dcyze9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have some trouble using the suspend in ram with the sama5d3.

When the cpu execute code from pm_slowclock.S, the cpu "crash", I mean
when I connect the JTAG, the program counter has an invalid/nonsense
value.

I have tried with the patch series from Wenyou Yang :
[PATCH 0/3] ARM: at91: add enter standby mode for ARMv7
but this doesn't change anything.

The code in pm_slowclock.S doesn't seem to have been test on the sama5d3

Is there anybody who succeeded to use the slowclock with the sama5d3 ?

I'm using the linux 3.10 from github.com/linux4sam.
