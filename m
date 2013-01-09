From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Jan 2013 15:33:58 -0200
Subject: [RFC PATCH 0/5] Use SRC to reset IP modules on i.MX5 and i.MX6
In-Reply-To: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5Cgem3xyYg9MawnxXx_tDKgtiA_g6odu2wtnAeXWjdfmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 3:17 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
>
> The following patches allow to link modules and SRC reset lines via phandle
> properties in the device tree. Drivers can then request their IP modules
> to be reset by the SRC.
> The IPU driver is made to use this mechanism during initialization, to
> improve robustness in the case of bootloaders leaving the IPU enabled.
>
> Fabio, does this help with your spurious interrupt issue?

I would like to give it a trym but I got some errors when trying to
apply these patches.

Which git tree should I use, or maybe do you have a git tree with them
applied so that I can quickly try?

Thanks,

Fabio Estevam
