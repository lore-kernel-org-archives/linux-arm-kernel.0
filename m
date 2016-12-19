From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Dec 2016 12:33:44 -0300
Subject: [PATCH] ARM: dts: imx: Pass an empty 'chosen' node
In-Reply-To: <1482161298-32624-1-git-send-email-fabio.estevam@nxp.com>
References: <1482161298-32624-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <ea4488a7-2c19-b92d-3c9f-f9260b7fdfbf@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On 12/19/2016 12:28 PM, Fabio Estevam wrote:
> Commit 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi") causes boot
> issues when the bootloader does not create a 'chosen' node if such node
> is not present in the dtb.
> 
> The reason for the boot failure is well explained by Javier Martinez
> Canillas: "the decompressor relies on a pre-existing chosen node to be
> available to insert the command line and merge other ATAGS info."
> 
> , so pass an empty 'chosen' node to fix the boot problem.
> 
> This issue has been seen in the kernelci reports with Barebox as
> bootloader.
> 
> Fixes: 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
