From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 5 Nov 2012 02:41:24 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc3
In-Reply-To: <508F59FB.7080400@ti.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508F59FB.7080400@ti.com>
Message-ID: <alpine.DEB.2.00.1211050239530.23228@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 30 Oct 2012, Vaibhav Hiremath wrote:

> This is surprising, I have tested v3.7-rc3 branch on AM335xBone platform
> and its booting up for me without any issues.
> Jon had submitted another patch which fixes boot issue on Bone.
> 
> https://patchwork.kernel.org/patch/1606471/

v3.7-rc4 failed for me with a detached .dtb in a quick test.  Probably it 
is due to the original u-boot that was shipped with the MMC card:

U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)
arm-arago-linux-gnueabi-gcc (GCC) 4.5.3 20110311 (prerelease)


Which U-boot are you using these days?


- Paul
