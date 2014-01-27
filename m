From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 20:45:34 +0000
Subject: [PATCH 3/4] ASoC: tda998x: add DT documentation
In-Reply-To: <20140127204302.GY11841@sirena.org.uk>
References: <cover.1390813480.git.moinejf@free.fr>
 <22fafd7e11771ffc25c84ff609d18039f07b7295.1390813481.git.moinejf@free.fr>
 <20140127204302.GY11841@sirena.org.uk>
Message-ID: <20140127204534.GB15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 08:43:02PM +0000, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 09:34:49AM +0100, Jean-Francois Moine wrote:
> 
> > +	- compatible: must be "nxp,tda998x-codec".
> > +	- audio-ports: one or two values.
> > +		The first value defines the I2S input port.
> > +		The second one, if present, defines the S/PDIF input port.
> 
> I take it these are port numbers on the device and it's not possible to
> do something like having multiple I2S ports?

You can feed it with multiple synchronised I2S streams for the additional
channels.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
