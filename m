From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 20:56:27 +0000
Subject: [PATCH 3/4] ASoC: tda998x: add DT documentation
In-Reply-To: <20140127204534.GB15937@n2100.arm.linux.org.uk>
References: <cover.1390813480.git.moinejf@free.fr>
 <22fafd7e11771ffc25c84ff609d18039f07b7295.1390813481.git.moinejf@free.fr>
 <20140127204302.GY11841@sirena.org.uk>
 <20140127204534.GB15937@n2100.arm.linux.org.uk>
Message-ID: <20140127205627.GD11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 08:45:34PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 27, 2014 at 08:43:02PM +0000, Mark Brown wrote:
> > On Mon, Jan 27, 2014 at 09:34:49AM +0100, Jean-Francois Moine wrote:

> > > +	- audio-ports: one or two values.
> > > +		The first value defines the I2S input port.
> > > +		The second one, if present, defines the S/PDIF input port.

> > I take it these are port numbers on the device and it's not possible to
> > do something like having multiple I2S ports?

> You can feed it with multiple synchronised I2S streams for the additional
> channels.

Ah, I feared as much.  The bindings ought to take account of that
posibility even if the code can't use additional ports yet.  Perhaps
separate properties for I2S and S/PDIF?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/5b441d2e/attachment.sig>
