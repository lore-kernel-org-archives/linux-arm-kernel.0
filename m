From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  7 May 2018 11:21:19 -0700
Subject: [PATCH v2] ARM: dts: cygnus: fix irq type for arm global timer
In-Reply-To: <20180503153207.7668-1-peron.clem@gmail.com>
References: <20180503153207.7668-1-peron.clem@gmail.com>
Message-ID: <20180507182119.27016-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  3 May 2018 17:32:07 +0200, Cl?ment P?ron <peron.clem@gmail.com> wrote:
> As per ARM documentation
> PPI(0) ID27 - global timer interrupt is rising-edge sensitive.
> 
> set IRQ triggering type to IRQ_TYPE_EDGE_RISING for ARM Global timers.
> 
> Fixes: c9ad7bc5fe3 ("ARM: dts: Enable Broadcom Cygnus SoC")
> Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
