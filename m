From: tj@kernel.org (Tejun Heo)
Date: Sun, 29 Sep 2013 08:51:28 -0400
Subject: =?utf-8?B?5Zue5aSN77yaUmU=?= =?utf-8?Q?=3A?= [v1] ahci: imx:
 setup power saving methods
In-Reply-To: <20130929074817.GG26156@S2101-09.ap.freescale.net>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130927131441.GA3205@htj.dyndns.org>
 <20130929073528.GE26156@S2101-09.ap.freescale.net>
 <1vugbd691bjfibh5crdihlrh.1380440262216@email.android.com>
 <20130929074817.GG26156@S2101-09.ap.freescale.net>
Message-ID: <20130929125128.GA7599@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 03:48:18PM +0800, Shawn Guo wrote:
> On Sun, Sep 29, 2013 at 07:40:57AM +0000, Zhu Richard-R65037 wrote:
> > Hi Shawn:
> > Thanks.
> > The hot-plug can?t be supported, if we support this method unconditionally.
> 
> Ah, okay.  Then you should make this clear in the help text of the
> Kconfig option.

Yeah but it's still weird to require kernel build to flip this
feature, isn't it?  Shouldn't it be a module param or something?

Thanks.

-- 
tejun
