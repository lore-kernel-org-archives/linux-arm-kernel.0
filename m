From: tj@kernel.org (Tejun Heo)
Date: Tue, 23 Jul 2013 12:26:23 -0400
Subject: [v3 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <0E83723C55F66F43A6041464FE31119D3441A3@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705174305.GA28088@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130706020737.GA9029@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D3441A3@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <20130723162623.GD21100@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jul 22, 2013 at 07:02:56AM +0000, Zhu Richard-R65037 wrote:
> Re-send this email to you and community.
> I'm afraid that you may be missed or don't receive it.

Sorry about the delay.  I was on the road.

> BTW, can you help to pick up the #2 and #3(reviewed and acked by Shawn) of the v7 patch-set of this serial?
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Just one thing, can you please rename the driver to ahci_imx?  I'd
like to keep all ahci drivers with ahci prefix (yeah, there's already
an exception, I know).

Thanks.

-- 
tejun
