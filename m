From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 May 2012 09:44:04 +0100
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <20120510063904.GB17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
Message-ID: <20120510084403.GA3908@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 02:39:06PM +0800, Shawn Guo wrote:
> On Thu, May 10, 2012 at 08:35:33AM +0800, Richard Zhao wrote:

> > It's based on your for-next. But for working, it depends on
> > pinctl/for-next.

> Mark, may I have your ack to have it go through arm-soc?  I will ask
> Arnd pull your sound/for-v3.5 branch into arm-soc as a dependency.
> You need to ensure the branch will not be rebased.

for-3.5 is the entire undifferentiated blob of ASoC stuff, it's not
really suitable for merging elsewhere.  It won't actually get rebased
but the idea of merging it into other trees doesn't seem terribly
clever, it'd make having topic branches in arm-soc a bit of a joke and
if you pull it right now you'll get problems in -next due to the the
ux500 stuff.

What does "working" mean in this context - what happens without the
pinctl changes?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120510/b22fa77a/attachment-0001.sig>
