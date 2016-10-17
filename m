From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Oct 2016 11:49:36 +0100
Subject: master build: 2 failures 4 warnings (v4.8-11811-g35ff96d)
In-Reply-To: <5682869.nmeogTxQJD@wuerfel>
References: <E1btqa6-0001tx-HV@optimist>
 <20161011101630.xtlcpw76nwjwcbzg@sirena.org.uk>
 <20161014103344.GB3304@dell> <5682869.nmeogTxQJD@wuerfel>
Message-ID: <20161017104936.GA10208@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 10:12:04PM +0200, Arnd Bergmann wrote:
> On Friday, October 14, 2016 11:33:44 AM CEST Lee Jones wrote:

> > I'm waiting on a firm answer from Arnd and Thomas before applying
> > anything.

> I don't understand what the hardware does, so I'm not really
> able to answer this. Maybe just mark the driver as 'depends on
> BROKEN' for now?

There are a few boards using it, we should probably revert the broken
patches rather than just completely disable the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161017/3b8b7d09/attachment-0001.sig>
