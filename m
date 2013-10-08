From: r65037@freescale.com (Zhu Richard-R65037)
Date: Tue, 8 Oct 2013 07:02:40 +0000
Subject: =?utf-8?B?UkU6IOWbnuWkje+8mlJlOiBbdjFdIGFoY2k6IGlteDogc2V0dXAgcG93ZXIg?=
 =?utf-8?Q?saving_methods?=
In-Reply-To: <20130929125128.GA7599@htj.dyndns.org>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130927131441.GA3205@htj.dyndns.org>
 <20130929073528.GE26156@S2101-09.ap.freescale.net>
 <1vugbd691bjfibh5crdihlrh.1380440262216@email.android.com>
 <20130929074817.GG26156@S2101-09.ap.freescale.net>
 <20130929125128.GA7599@htj.dyndns.org>
Message-ID: <0E83723C55F66F43A6041464FE31119D3FBC68@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun:
I'm back from holiday, Thanks for your review and suggestions.
The kernel build option would be replaced by the usage of the module parameters.

Best Regards
Richard Zhu


-----Original Message-----
From: Tejun Heo [mailto:htejun at gmail.com] On Behalf Of Tejun Heo
Sent: Sunday, September 29, 2013 8:51 PM
To: Shawn Guo
Cc: Zhu Richard-R65037; Richard Zhu; linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com; linux-ide at vger.kernel.org
Subject: Re: ???Re: [v1] ahci: imx: setup power saving methods

On Sun, Sep 29, 2013 at 03:48:18PM +0800, Shawn Guo wrote:
> On Sun, Sep 29, 2013 at 07:40:57AM +0000, Zhu Richard-R65037 wrote:
> > Hi Shawn:
> > Thanks.
> > The hot-plug can?t be supported, if we support this method unconditionally.
> 
> Ah, okay.  Then you should make this clear in the help text of the 
> Kconfig option.

Yeah but it's still weird to require kernel build to flip this feature, isn't it?  Shouldn't it be a module param or something?

Thanks.

--
tejun
