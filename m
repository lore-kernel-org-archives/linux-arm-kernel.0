From: tj@kernel.org (Tejun Heo)
Date: Wed, 26 Mar 2014 11:41:11 -0400
Subject: [PATCH] ata: fix Calxeda Highbank SATA driver dependencies
In-Reply-To: <2920312.TnoQcCR5HX@amdc1032>
References: <2920312.TnoQcCR5HX@amdc1032>
Message-ID: <20140326154111.GF7171@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 04:39:50PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make sata_highbank host driver depend on ARCH_HIGHBANK config option
> as Calxeda Highbank SATA support is specific to Calxeda Highbank
> SoCs and the driver to work requires suitable device tree node to
> be defined.  Additionally allow the driver build if COMPILE_TEST
> config option is set.
> 
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
