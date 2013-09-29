From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 29 Sep 2013 15:48:18 +0800
Subject: =?utf-8?B?5Zue5aSN77yaUmU=?= =?utf-8?Q?=3A?= [v1] ahci: imx:
 setup power saving methods
In-Reply-To: <1vugbd691bjfibh5crdihlrh.1380440262216@email.android.com>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130927131441.GA3205@htj.dyndns.org>
 <20130929073528.GE26156@S2101-09.ap.freescale.net>
 <1vugbd691bjfibh5crdihlrh.1380440262216@email.android.com>
Message-ID: <20130929074817.GG26156@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 07:40:57AM +0000, Zhu Richard-R65037 wrote:
> Hi Shawn:
> Thanks.
> The hot-plug can?t be supported, if we support this method unconditionally.

Ah, okay.  Then you should make this clear in the help text of the
Kconfig option.

Shawn
