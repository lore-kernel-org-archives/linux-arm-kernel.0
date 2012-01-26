From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jan 2012 20:33:50 +0000
Subject: at91: pm.h cleanup (was: [PATCH 1/4] at91 : coding style fixes)
In-Reply-To: <4F217CCD.5000104@atmel.com>
References: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
 <4F217CCD.5000104@atmel.com>
Message-ID: <20120126203350.GD11941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 05:18:21PM +0100, Nicolas Ferre wrote:
> Daniel,
> 
> I have rebased your patch series on top of:
> 
> - at91 late device/board patches that are planned for 3.3
> - at91-fixes branch (should go also in 3.3)
> * rmk/for-next branch (with a merge conflict resolved)
> * the removal of CAP9 SoC family
> 
> You can find the resulting code in our git tree:
> 
> git://github.com/at91linux/linux-at91.git at91-pm_cleanup
> 
> I hope that I will be able to send this branch to arm-soc soon with a
> minimum of future rebase (when the two first series cited above will be
> in Linus' tree actually).

No you won't, not if you're including rmk/for-next in it.

Take a moment to think about that: rmk/for-next is NOT a topic branch.
It is purely a branch published for the sake of SFR.  It gets torn down
and regenerated regularly.  You can't base work off it.  It's all explained
here:

	http://www.arm.linux.org.uk/developer/git-arm.php
