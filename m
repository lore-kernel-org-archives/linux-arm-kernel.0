From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 9 Jun 2016 14:29:14 +0900
Subject: [PATCH V2 2/2] ARM64: tegra: Add device node for system PMIC
 MAX77620
In-Reply-To: <1465299897-2491-2-git-send-email-ldewangan@nvidia.com>
References: <1465299897-2491-1-git-send-email-ldewangan@nvidia.com>
 <1465299897-2491-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <CAAVeFuJeVLs7avKgs+YZn_JZ+jeJ9sScEHx6LrQ1aN0QFvhjLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 8:44 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> Jetson-TX1 uses the Maxim MAX77620 as system Power management IC.
> Add device node for the MAX77620 with following details:
> - Add device max77620 with.
>         - Add all pins configurations.
>         - Configure FPS of the device.
>         - Configure SD/DCDC and LDOs regulators.
> - populate the bus expander on base board P2597.
> - Populate all fixed voltage regulators controlled by GPIOs from Tegra,
>   PMIC and bus expanders.
>
> For the different details, jetson-CV device tree files are referred from
> downstream.

I think Thierry posted a similar change:

http://permalink.gmane.org/gmane.linux.ports.tegra/26815
