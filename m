From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 24 Jan 2013 07:42:06 +0100
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
In-Reply-To: <5100C0F7.9080101@wwwdotorg.org>
References: <CAOesGMgtaCkiv285TU_vbAokN5M2MrANQ9piDcyXu5YMmbQq3A@mail.gmail.com><50FFA620.50008@ti.com><5100C0F7.9080101@wwwdotorg.org>
Message-ID: <20130124.084206.122831115046505200.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Thu, 24 Jan 2013 06:04:55 +0100:

> Branch scu-base-rework contains just the SCU base address patches. After
> the few things listed below, I'll rename this branch and send a pull
> request to arm-soc.
> 
....
> 2) Lorenzo's last comment on "ARM: tegra: Use DT /cpu node to detect
> number of CPU core" was:
> 
> Please add missing punctuation, reword the commit log to make it clearer.
> 
> ... so that patch needs a reworded commit log.

I fixed. I'll send this[1] as a part of the "Tegra114 series(v4)" today.

[1] ARM: tegra: Use DT /cpu node to detect number of CPU core
