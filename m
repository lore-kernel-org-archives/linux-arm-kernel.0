From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 14 Oct 2013 12:20:03 +0200
Subject: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
In-Reply-To: <525A732D.3080708@linaro.org>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>
 <20131013111945.0251a3cc@skate> <525A732D.3080708@linaro.org>
Message-ID: <3135182.xhXUMRLLGy@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Daniel,

On Sunday, October 13, 2013 12:17:17 PM Daniel Lezcano wrote:
> On 10/13/2013 11:19 AM, Thomas Petazzoni wrote:
> > Dear Daniel Lezcano,
> >
> > On Sat, 12 Oct 2013 17:51:39 +0200, Daniel Lezcano wrote:
> >
> >> +config ARM_AT91_CPUIDLE
> >> +        bool "Cpu Idle Driver for the AT91 processors"
> >
> > Nitpick: indentation is done with spaces here, while it should be one
> > tab.
> 
> Ah, right. Fixed for the V2.

Could you also please add 'default y' to preserve the old behavior?
(the at91 cpuidle support was always built-in for CONFIG_CPU_IDLE=y)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
