From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 7 Mar 2017 12:45:15 +0100
Subject: [PATCH] ARM: dts: imx6q-bx50v3/imx6q-b450v3/imx6q-b650v3: change
 pca953x GPIO default settings
In-Reply-To: <20170203012114.20411-1-ken.lin@advantech.com>
References: <20170203012114.20411-1-ken.lin@advantech.com>
Message-ID: <20170307114514.GA6585@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2017 at 09:21:14AM +0800, Ken Lin wrote:
> Leave pca953x P06,P07 pins on b850v3 platform and P06 pin on b450v3/b650v3 unconfigured
> in the kernel space since they could be configured as DP1_RST and DP2_RST by the applications
> for the DP FW update support
> 
> Signed-off-by: Ken Lin <ken.lin@advantech.com>

I wrapped commit log and shorten the subject prefix a bit, and then
applied the patch.

Shawn
