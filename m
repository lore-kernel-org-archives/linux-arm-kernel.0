From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 26 Jan 2012 17:18:21 +0100
Subject: at91: pm.h cleanup (was: [PATCH 1/4] at91 : coding style fixes)
In-Reply-To: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
References: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F217CCD.5000104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

I have rebased your patch series on top of:

- at91 late device/board patches that are planned for 3.3
- at91-fixes branch (should go also in 3.3)
* rmk/for-next branch (with a merge conflict resolved)
* the removal of CAP9 SoC family

You can find the resulting code in our git tree:

git://github.com/at91linux/linux-at91.git at91-pm_cleanup

I hope that I will be able to send this branch to arm-soc soon with a
minimum of future rebase (when the two first series cited above will be
in Linus' tree actually).

FYI, the four patch series that will be the base of all our 3.4 work is
also stored in a branch: at91-3.4-base

Thanks, best regards,
-- 
Nicolas Ferre
