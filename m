From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Feb 2012 15:10:12 -0800
Subject: [PATCH v2] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
In-Reply-To: <1329929103-28486-1-git-send-email-mporter@ti.com>
References: <1329929103-28486-1-git-send-email-mporter@ti.com>
Message-ID: <20120222231012.GW18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@ti.com> [120222 08:13]:
> This fixes smsc911x support on platforms using gpmc_smsc911x_init().
> 
> Commit c7e963f6888816 (net/smsc911x: Add regulator support) added
> the requirement that platforms provide vdd33a and vddvario supplies.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
> Changes for v2:
>    - temporary fix to avoid platform device id conflicts
>    - add commit summary from the smsc911x regulator support commit
>    - incorporate platform device registration error cause reporting 

Thanks applying into fixes.

Tony
