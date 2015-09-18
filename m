From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 18 Sep 2015 12:45:06 -0300
Subject: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <BN3PR0301MB08674C65714A9423E39E1F10FE590@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1442480614-32345-1-git-send-email-b18965@freescale.com>
 <20150917103414.GN21084@n2100.arm.linux.org.uk>
 <BN3PR0301MB08674C65714A9423E39E1F10FE590@BN3PR0301MB0867.namprd03.prod.outlook.com>
Message-ID: <CAOMZO5BUvq3LydjL7cR2hAWFFUB+Cvwi+yEN5A9uG=uWEDepiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 4:38 AM, Huan Wang <alison.wang@freescale.com> wrote:

> [Alison Wang] Thanks for your reply. I agreed with you about creating
> a new multi_v7_lpae_defconfig. In multi_v7_lpae_defconfig, I need to add
> the following CONFIG_XX to support LS1021A based on multi_v7_defconfig.
>
> CONFIG_ARM_LPAE=y
> CONFIG_VMSPLIT_2G=y

Is CONFIG_VMSPLIT_2G=y really needed?
