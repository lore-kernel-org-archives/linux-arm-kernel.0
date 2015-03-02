From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Mar 2015 14:06:38 +0000
Subject: [alsa-devel] [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
In-Reply-To: <20150302134253.GQ4094@piout.net>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106174521.GM2634@sirena.org.uk>
 <20150302134253.GQ4094@piout.net>
Message-ID: <20150302140638.GW21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 02:42:53PM +0100, Alexandre Belloni wrote:
> On 06/01/2015 at 17:45:21 +0000, Mark Brown wrote :
> > On Tue, Jan 06, 2015 at 12:14:32PM +0100, Alexandre Belloni wrote:

> > > Atmel based boards can now only be used with device tree. Drop non DT
> > > initialization.

> > Applied, thanks.

> I don't see that patch in 4.0-rc1. This will lead to a compilation error
> as all the machine_is_at91xxx have been removed.

*sigh*  If something is a bug fix then please flag it as such; nothing
in your message gives any hint that this is a fix rather than just a
random cleanup.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150302/08a50a2b/attachment.sig>
