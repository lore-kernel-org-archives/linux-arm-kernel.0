From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Aug 2014 11:06:36 +0100
Subject: [PATCH 0/8] mtd: nand: Support for new DT NAND driver
In-Reply-To: <20140818083953.GA4266@lee--X1>
References: <1407921127-8590-1-git-send-email-lee.jones@linaro.org>
 <20140814224013.GE18411@ld-irv-0074>
 <20140818083953.GA4266@lee--X1>
Message-ID: <20140818100636.GB4266@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Particularly, take a hard look at rewriting
> > include/linux/mtd/stm_nand_bbt.h.
> 
> I don't think there is any need - although this change is required:
> 
> -#if defined(MTD_NAND_STM_BBT)
> +#if defined(MTD_NAND_STM_BCH_BBT)

Sorry, I mean this:

-#if defined(MTD_NAND_STM_BBT)
+#if defined(CONFIG_MTD_NAND_STM_BCH_BBT)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
