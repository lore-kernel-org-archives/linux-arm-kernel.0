From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Fri, 7 Sep 2012 05:30:13 +0000
Subject: [PATCH v7 0/3] arm/dts: Add device tree data for AM33XX devices
In-Reply-To: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
References: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA293E9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 15:08:21, AnilKumar, Chimata wrote:
> Add pinctrl and d_can device tree data to AM33XX family of devices.
> First two patches add support for pinctrl DT data and third one
> adds dcan DT data.
> 
> Reason behind combining these patches is to apply cleanly on
> linux-omap tree, because these are sequential patches.
> 
> These patches were tested on AM335x-Bone, AM335x-EVM and based
> on linux-omap:master with this patch
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg74393.html
> 

If there are no changes in this patch series ACK from
reviewers (esp. Tony, koen and Marc) will help.

Thanks
AnilKumar
