From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 10:16:48 +0200
Subject: [PATCH v2] clk: add LP8788 clock driver
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E4AB29@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E4AB29@DQHE02.ent.ti.com>
Message-ID: <20130409081648.GJ24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milo,

On Thu, Apr 04, 2013 at 01:34:37AM +0000, Kim, Milo wrote:
> Patch v2.
>   (a) Remove unnecessary 'is_enabled()' operation code.
>   (b) Add CLK_IGNORE_UNUSED flag.
>   (c) Add clock device detection code : lp8788_is_clk_device_ready()
>       If the device is not ready, return as -ENODEV on loading the driver.
> 
> Patch v1.
>   Initial patch
> 
> Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
> ---
>  drivers/clk/Kconfig        |    7 ++
>  drivers/clk/Makefile       |    1 +
>  drivers/clk/clk-lp8788.c   |  160 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/lp8788.c       |    2 +
>  include/linux/mfd/lp8788.h |    1 +
>  5 files changed, 171 insertions(+)
>  create mode 100644 drivers/clk/clk-lp8788.c
For the MFD part:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
