From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Jul 2013 14:01:39 +0100
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <2214161.FSfscAvpna@thinkpad>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <29860116.IF545KsGYb@thinkpad>
 <20130711112023.GM24508@sirena.org.uk>
 <2214161.FSfscAvpna@thinkpad>
Message-ID: <20130711130139.GQ24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 01:41:40PM +0200, Tomasz Figa wrote:
> On Thursday 11 of July 2013 12:20:23 Mark Brown wrote:

> > This is a bit of a larger project sadly, there was resistance to doing
> > the DT bindings based on compatible strings using the IP version :(

> I'm not sure if this case is related to this problem in any way. I just 
> suggested introducing a new include like samsung,exynos5420-i2s, a opposed to 
> using samsung,exynos5250-i2s and adding flags, since the I2S in Exynos5420 is 

Well, it *should* be samsung,i2s-vN where N is the version number of the
IP but documentation on the versioning has been patchy hence this whole
thinng.

> the first one to have this TDM or whatever mode. (I'd still like to hear what 
> it is...)

What it *should* be is the option to send more than one audio stream
down a link using time division multiplexing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/36342c14/attachment.sig>
