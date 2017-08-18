From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Aug 2017 12:52:23 +0100
Subject: [PATCH v3 2/9] ASoC: rockchip: Remove obsolete dmic-delay
In-Reply-To: <599645E2.4020402@rock-chips.com>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-3-jeffy.chen@rock-chips.com>
 <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
 <599645E2.4020402@rock-chips.com>
Message-ID: <20170818115223.pyfqji5jkplt6isx@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 09:41:54AM +0800, jeffy wrote:
> On 08/18/2017 01:11 AM, Mark Brown wrote:
> > On Thu, Aug 17, 2017 at 12:44:10PM +0800, Jeffy Chen wrote:

> > > -Optional properties:
> > > -- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
> > > -  If this option is specified, which means it's required dmic need
> > > -  delay for DMIC to ready so that rt5514 can avoid recording before
> > > -  DMIC send valid data

> > Why would nobody ever want to use this in future?

> hmmm, check again, rt5514 fixed this issue in there driver instead in:
> a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.

> so we don't need this...

You don't need it on your board for new DTs but why is it not possible
that another board might need it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/356d4567/attachment.sig>
