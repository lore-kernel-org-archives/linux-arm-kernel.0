From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jun 2014 12:18:23 +0100
Subject: [PATCH] arm: exynos: Modify pm code to check for cortex A9
 rather than the SoC
In-Reply-To: <CAM4voak4ZD0OHWoto7j2TyYBmpaWH3JH4ug3+hsxeL+WUhE9jA@mail.gmail.com>
References: <1400814061-12813-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voa=3zzo-2KbjDtBOca+uJeSxT2OYpi+rJuSGsDg-vo7GYA@mail.gmail.com>
 <20140624161114.GW32514@n2100.arm.linux.org.uk>
 <CAM4voak4ZD0OHWoto7j2TyYBmpaWH3JH4ug3+hsxeL+WUhE9jA@mail.gmail.com>
Message-ID: <20140625111823.GH32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 10:30:46AM +0530, Abhilash Kesavan wrote:
> I see that you have sent a patch out that ensures both part and
> implementor number are checked. Currently, my patch has been applied
> to the fixes branch of the arm-soc tree and I wanted to know how to
> proceed (without it there is a crash on the 5420):
> Should I request Arnd to drop it (if possible) and send out a new
> patch using your updated function ?

I'll hold my patch off - as yours is in the fixes branch, it should end
up in a -rc release.  Mine isn't -rc material.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
