From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Oct 2011 16:47:02 +0200
Subject: [PATCH 22/30] mfd: build twl6030 only on omap2
In-Reply-To: <20111004104713.GY4118@sortiz-mobl>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-23-git-send-email-arnd@arndb.de>
	<20111004104713.GY4118@sortiz-mobl>
Message-ID: <201110041647.02690.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 October 2011, Samuel Ortiz wrote:
> On Sun, Oct 02, 2011 at 04:45:52PM +0200, Arnd Bergmann wrote:
> > We can only have one pwm driver built into the kernel,
> I seem to remember that Bill Gatliff was working on a PWM subsystem that would
> get rid of the current pwm.h ugliness. Do we have any updates on this one ?

I don't know if the work on the pwm subsystem is progressing right now,
there were at one point two competing patches, but so far neither of them
has made it into linux-next.
 
> The patch below looks like a hack to me, trying to work around the current
> lack of such subsystem.

Absolutely. I'll clarify this in the patch description when I fix the
bug pointed out by Balaji T Krishnamoorthy.

	Arnd
