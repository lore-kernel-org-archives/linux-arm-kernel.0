From: broonie@kernel.org (Mark Brown)
Date: Fri, 5 Jul 2013 11:12:04 +0100
Subject: SPI: DUAL/QUAD support
In-Reply-To: <CAHSAbzNBkZPFOfGHqFxZH_id=PFj=BmZ4Q302zGKeM-0yJBtHg@mail.gmail.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704143645.GA27646@sirena.org.uk>
 <20130704180656.GA1974@sig21.net>
 <20130704191216.GK27646@sirena.org.uk>
 <CAHSAbzNBkZPFOfGHqFxZH_id=PFj=BmZ4Q302zGKeM-0yJBtHg@mail.gmail.com>
Message-ID: <20130705101204.GT27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 05:41:57PM +0800, yuhang wang wrote:

> Yes. I agree with you. This should be described in SPI level.
> So to SPI controller, if it has the ability to transfer in 2x or 4x, but
> what a pity no device can tell this info to it. No matter what the slave
> is and no matter whether they will use the spi transfer width member,
> firstly SPI controller should provide these members. If the slave do
> not set the member, that means the slave wants to communicate
> in 1 line traditionally.

Yes, it definitely makes sense to have this as a feature in the SPI
core.  We just need a good API for it, which I think is mostly just
about working out what to call things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/71080f89/attachment.sig>
