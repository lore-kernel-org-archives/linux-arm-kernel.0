From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Feb 2014 11:50:29 +0100
Subject: [PATCH 1/3] reset: Add of_reset_control_get
In-Reply-To: <1389179494.4297.9.camel@pizza.hi.pengutronix.de>
References: <1387575669-21253-1-git-send-email-maxime.ripard@free-electrons.com>
 <1387575669-21253-2-git-send-email-maxime.ripard@free-electrons.com>
 <20131221094213.03658852@skate>
 <1389030171.5590.31.camel@pizza.hi.pengutronix.de>
 <20140108103843.GA2941@lukather>
 <1389179494.4297.9.camel@pizza.hi.pengutronix.de>
Message-ID: <20140205105029.GD3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Wed, Jan 08, 2014 at 12:11:34PM +0100, Philipp Zabel wrote:
> > How do you want to get this merged? You'll probably want to take this
> > patch, and patches 2/3 and 3/3 depend on some patches merged by Daniel
> > Lezcano (that I forgot to CC on this, I'll resend).
> > 
> > Maybe the best way would be simply to merge this one for 3.14 through
> > your branch, and merge the two other patches in 3.15.
> 
> Alright, this is applied to my branch. I'll wait a bit for feedback on
> the GPIO reset patches and then send a pull request.

It doesn't seem to be in 3.14. Did I miss something?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/611bab2f/attachment.sig>
