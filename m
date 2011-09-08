From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 17:20:18 +0200
Subject: [GIT PULL] i.MX features for next
In-Reply-To: <20110906192229.GK28816@pengutronix.de>
References: <20110823115658.GK31404@pengutronix.de>
	<20110826082644.GD7526@pengutronix.de>
	<20110906192229.GK28816@pengutronix.de>
Message-ID: <201109081720.18929.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 September 2011, Uwe Kleine-K?nig wrote:
> if I remember correctly you don't mind non-fast-forward updates?! If I'm
> wrong just tell me. 

Right, I can take a limited number of those at least. I want a reasonable
git history, not a stainless one ;-)

> Compared to Sascha's pull request this mail is a reply to, the following
> changed:
> 
>  - squash a patch by Jason Liu <jason.hui@linaro.org> into
>    d27536c6619221528114746317def345467a3e80 fixing a build failure for
>    mx25 (1314623624-9999-1-git-send-email-jason.hui at linaro.org)
>  - squash a patch by Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
>    into 236c4e8be436380b5354fe0d7facf94688e024ec fixing the resource
>    size for pata_imx devices (20110827131911.571434313 at rtp-net.org)
>  - two new patches:
>    "ARM: mx51/efika: Configure esdhc cd/wp on efika mx/sb" and "ARM: mx5: fix clock
>    usage for suspend" both by Arnaud Patard.
> 
> I choosed to squash the two fixes to ease bisection.
> Though the 2nd patch by Arnaud fixes suspend, I think it's not necessary
> to go in before v3.1.

There were a few other pull requests that I haven't taken yet since
master.kernel.org is down. If the general feeling is that I should take
at least the bug fixes, I can start a branch on the linaro server for that.

	Arnd
