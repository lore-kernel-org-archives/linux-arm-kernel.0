From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Mar 2015 17:53:25 +0000
Subject: [alsa-devel] [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
In-Reply-To: <20150302141940.GR4094@piout.net>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106174521.GM2634@sirena.org.uk>
 <20150302134253.GQ4094@piout.net>
 <20150302140638.GW21293@sirena.org.uk>
 <20150302141940.GR4094@piout.net>
Message-ID: <20150302175325.GZ21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 03:19:40PM +0100, Alexandre Belloni wrote:
> On 02/03/2015 at 14:06:38 +0000, Mark Brown wrote :

> > *sigh*  If something is a bug fix then please flag it as such; nothing
> > in your message gives any hint that this is a fix rather than just a
> > random cleanup.

> Well, I though this would be applied along with
> "ASoC: atmel: sam9g20_wm8731: remove useless include" which made it to
> 4.0-rc1 and was also a simple cleanup.

That's one line as opposed to an at least mechanically large change.

> It was a simple cleanup until all the machine_is_at91xxx got dropped :)

Which shouldn't have happened while there were still users.  :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150302/8bfadb04/attachment.sig>
