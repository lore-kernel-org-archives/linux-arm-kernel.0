From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 May 2012 10:25:36 +0100
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <20120510090715.GF17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090715.GF17875@S2101-09.ap.freescale.net>
Message-ID: <20120510092536.GG3908@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 05:07:18PM +0800, Shawn Guo wrote:

> Pulling it into arm-soc as a dependency only means we will have it as
> a base for other branches that depend on.  It does not change anything
> about how the branch flows to Linus.  Arnd will only send those arm-soc
> branches that depend on sound/for-3.5 after it gets merged by Linus.

I don't see what difference that really makes to anything...  exactly
who sends pull requests to Linus is pretty immaterial, really.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120510/5b8e1ee2/attachment-0001.sig>
