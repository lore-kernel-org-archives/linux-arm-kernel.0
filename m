From: sr@denx.de (Stefan Roese)
Date: Wed, 8 Feb 2012 08:16:10 +0100
Subject: [PATCH 4/6 v3] of/mtd/nand: add generic bindings and helpers
In-Reply-To: <1328631510-11688-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328524512-18159-1-git-send-email-plagnioj@jcrosoft.com>
 <1328631510-11688-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <201202080816.10890.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 February 2012 17:18:30 Jean-Christophe PLAGNIOL-VILLARD wrote:
> - nand-ecc-mode : String, operation mode of the NAND ecc mode.
>   Supported values are: "none", "soft", "hw", "hw_syndrome",
> "hw_oob_first", "soft_bch".
> - nand-bus-width : 8 or 16 bus width if not present 8
> - nand-on-flash-bbt: boolean to enable on flash bbt option if not present
> false
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: devicetree-discuss at lists.ozlabs.org

Acked-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
