From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 10:24:59 +0200
Subject: [PATCH v10 0/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1431991481-25684-1-git-send-email-lho@apm.com>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
Message-ID: <2131612.4Ote0OTURi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 May 2015 17:24:36 Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC EDAC driver for DT.
> 
> v10:
> * Move regmap for CSW, MCBA, MCBB, and efuse to top driver node and add
>   accessor support functions
> * Change retrieval OF address proerty for subnode to use of_address_to_resource
> * Add COMPILE_TEST to Kconfig for EDAC_XGENE
> * Update DT binding documentation and DT node accordingly
> * Remove DT node naming and number from nodes
> 

Looks good to me. When you address my last comments, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
