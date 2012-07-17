From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jul 2012 15:22:22 +0100
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <50057058.2060002@linaro.org>
References: <5003FB7C.4030509@linaro.org>
 <20120717130650.GB27595@sirena.org.uk> <500568D9.10805@linaro.org>
 <20120717133550.GC4477@opensource.wolfsonmicro.com>
 <50057058.2060002@linaro.org>
Message-ID: <20120717142222.GE4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 03:02:00PM +0100, Lee Jones wrote:

> I'm sure sure this is relevant in the current case though, as the
> i2c properties proposed here are platform specific. What we're

I've not seen the specific example (though fankly it seems quite
surprising that there's anything other than bus speed that the platform
might want to configure for I2C...).

> discussing is some consolidation of property names, which I do
> support in theory. What I fear is that this driver will lack Device
> Tree functionality for yet another kernel version if it isn't
> resolved quickly.

Well, if checking the DT checky box is the important thing then just
adding an of_match_table ought to be enough?  It's fairly common for
platform data to have lots of stuff that's not used by most systems
so you can often cover 90% of systems with a very small subset of the 
configurability.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120717/d6cb8b1b/attachment.sig>
