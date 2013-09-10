From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Sep 2013 11:34:50 +0800
Subject: [PATCH v2 2/4] ARM: dts: add fec phy reset for imx6sl evk board
In-Reply-To: <9848F2DB572E5649BA045B288BE08FBE016A8DF9@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
 <1378182385-9205-3-git-send-email-B38611@freescale.com>
 <20130909145333.GA5815@S2101-09.ap.freescale.net>
 <9848F2DB572E5649BA045B288BE08FBE016A7AB8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20130910031138.GD5815@S2101-09.ap.freescale.net>
 <9848F2DB572E5649BA045B288BE08FBE016A8DF9@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20130910033448.GF5815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 03:23:26AM +0000, Duan Fugang-B38611 wrote:
> In fact, just for kernel, there have no sequence between the patch and driver patch because
> Kernel fec also cannot work for imx6sl evk if uboot don't do the initial.

True.  But in practice, we mostly use U-Boot to download kernel during
development.  So it's still a nice thing for kernel developers if we can
boot the board into console with NFS when FEC driver is not fully ready.

Shawn
