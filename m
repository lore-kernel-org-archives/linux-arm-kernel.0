From: tj@kernel.org (Tejun Heo)
Date: Wed, 26 Mar 2014 10:35:08 -0400
Subject: [PATCH] ata: fix ARASAN CompactFlash PATA driver dependencies
In-Reply-To: <1565826.7Ejj6LS6x7@amdc1032>
References: <1565826.7Ejj6LS6x7@amdc1032>
Message-ID: <20140326143508.GE7171@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 03:33:37PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make pata_arasan_cf host driver depend on ARCH_SPEAR13XX config
> option as ARASAN CompactFlash PATA support is specific to ST
> SPEAr13xx SoCs and the driver to work requires suitable device
> tree node (or platform device) to be defined.  Additionally
> allow the driver build if COMPILE_TEST config option is set.
> 
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.  Thanks.

-- 
tejun
