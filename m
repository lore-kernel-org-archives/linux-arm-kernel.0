From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 16:03:09 +0100
Subject: [alsa-devel] [PATCH RFC 00/13] Adding SPDIF support to
 kirkwood-i2s
In-Reply-To: <51FFB267.3030107@metafoo.de>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <51FFB267.3030107@metafoo.de>
Message-ID: <20130805150309.GM9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 04:10:47PM +0200, Lars-Peter Clausen wrote:

> In my opinion having different bindings for each board is not a good idea.
> Having a common set of property names will allow us to factor out the
> parsing to the ASoC core instead of doing this by hand for each board driver.

Yeah, that's the idea - right now there's blanks that need filling in by
the machine drivers so we do have them but once those get dealt with the
compatible strings can just be moved over into a generic binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/6e304dae/attachment.sig>
