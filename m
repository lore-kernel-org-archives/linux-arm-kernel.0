From: r65037@freescale.com (Zhu Richard-R65037)
Date: Wed, 24 Jul 2013 02:21:18 +0000
Subject: [v3 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <20130723162623.GD21100@mtj.dyndns.org>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705174305.GA28088@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130706020737.GA9029@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D3441A3@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130723162623.GD21100@mtj.dyndns.org>
Message-ID: <0E83723C55F66F43A6041464FE31119D34517C@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun:
Thanks a lot.

No problem, I can rename the driver from sata_imx to ahci_imx.

Best Regards
Richard Zhu


-----Original Message-----
From: Tejun Heo [mailto:htejun at gmail.com] On Behalf Of Tejun Heo
Sent: Wednesday, July 24, 2013 12:26 AM
To: Zhu Richard-R65037
Cc: Richard Zhu; shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com; avorontsov at ru.mvista.com; rob.herring at calxeda.com; s.hauer at pengutronix.de; linux-ide at vger.kernel.org
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms

Hello,

On Mon, Jul 22, 2013 at 07:02:56AM +0000, Zhu Richard-R65037 wrote:
> Re-send this email to you and community.
> I'm afraid that you may be missed or don't receive it.

Sorry about the delay.  I was on the road.

> BTW, can you help to pick up the #2 and #3(reviewed and acked by Shawn) of the v7 patch-set of this serial?
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Just one thing, can you please rename the driver to ahci_imx?  I'd like to keep all ahci drivers with ahci prefix (yeah, there's already an exception, I know).

Thanks.

--
tejun
