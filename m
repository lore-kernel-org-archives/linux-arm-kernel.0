From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2018 22:40:10 -0700
Subject: [PATCH 0/5] arm64: Initial support Texas Instrument's AM654
 Platform
In-Reply-To: <20180619194253.27288-1-nm@ti.com>
References: <20180619194253.27288-1-nm@ti.com>
Message-ID: <20180621054010.GE112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [180619 19:46]:
> Hi,
> This is an update from RFC posted earlier:
>         https://marc.info/?l=linux-arm-kernel&m=152817866312732&w=2
> 
> The following series enables support for newest addition in TI's SoC
> portfolio - AM654 SoC.
> 
> The series is based off v4.18-rc1, also available here:
> https://github.com/nmenon/linux-2.6-playground/tree/upstream/v4.18-rc1/k3-1-am6-base
> 
> Key changes since RFC are indicated in respective patches:
> * dt bindings updates (from review comments)
> * device tree is split up to incorporate ranges and bus segments
> * Cosmetic fixes including renaming the base dts to prevent confusion
> * UART has been split out

Other than the cbass to interrconnect naming, looks good to me now:

Reviewed-by: Tony Lindgren <tony@atomide.com>
