From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jan 2012 08:19:36 +0200
Subject: MXS: How to configure SGTL5000 ASoC as master?
Message-ID: <4F0BD878.40508@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

SGTL5000 ASoC is hard coded to be slave in sound/soc/mxs/mxs-sgtl5000.c. 
In our HW design mclk of ASoC is sourced from external oscillator. 
Because of our design ASoC should be configured as master. In that case 
master clock of SAIF should be disabled.

Is there any plan to have configuration for mxs-sgtl5000 driver? What is 
preferred way to solve this issue?

BR,
Lauri Hintsala

p.s. I resent this mail because I wasn't subscriber of alsa-devel 
mailing list.
