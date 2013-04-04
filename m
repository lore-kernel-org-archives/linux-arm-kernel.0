From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 05 Apr 2013 00:01:10 +0200
Subject: [PATCH v2 0/6] clk: sunxi: gates support
In-Reply-To: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <515DF826.2070408@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 27/03/2013 22:20, Emilio L?pez a ?crit :
> Hi,
> 
> This patchset adds support for the main sunxi gates; namely, those found 
> on AXI, AHB, APB0 and APB1 clocks. The series depends on Maxime's UART 
> rework and on the basic sunxi clock driver by me.
> 
> Patches 1 and 2 implement the actual gate support, and patch 3 switches 
> the UARTs to use the correct gates now that they are available.
> 
> Patch 4 and 5 add clock support to our pinctrl driver, as we need to 
> keep the pio clock running for gpio to work.
> 
> Patch 6 drops the ignore flags; now that we have actual clock users that 
> will keep the important clocks running.
> 
> Patch 7 is an unrelated oneliner to remove an unnecesary kmalloc call.
> 
> The main changes from v1 are renamed compatible strings and a clarification
> on the documentation, see each individual patch for more details.

I merged the patches 2, 3 and 5 into my sunxi/dt-for-3.10 branch.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
