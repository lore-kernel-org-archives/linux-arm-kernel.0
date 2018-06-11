From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 11 Jun 2018 14:01:58 +0200
Subject: handling voice calls in ALSA soc (on Droid 4)
In-Reply-To: <20180611111011.GA11580@sirena.org.uk>
References: <20180611102529.GA1272@amd> <20180611111011.GA11580@sirena.org.uk>
Message-ID: <20180611120158.GA21745@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-06-11 12:10:11, Mark Brown wrote:
> On Mon, Jun 11, 2018 at 12:25:30PM +0200, Pavel Machek wrote:
> 
> > ...and also. What is right interface for this? Mixer component that
> > says if voice call is active or not?
> 
> Your modem should be represented as a component in the system and have
> an input and an output representing the input and output on the cell
> network.  See speyside for an example of how this can look in software
> though there's a bunch of different ways modems can appear so you might
> not have a fully digital link like that.

Thanks for the pointer.

With setup like that, how does userland tell kernel that the baseband
<-> microphone/speaker connection should be activated?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180611/43c03f41/attachment.sig>
