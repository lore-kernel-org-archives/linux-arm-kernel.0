From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 23 Mar 2015 17:11:51 +0100
Subject: [PATCH 1/1] ARM: dts: don't make DP a consumer of DISP1 on
 Exynos5250
In-Reply-To: <5506E5D4.1020300@collabora.co.uk>
References: <1426320716-28137-1-git-send-email-javier.martinez@collabora.co.uk>
 <5506C945.5030603@suse.de> <5506E5D4.1020300@collabora.co.uk>
Message-ID: <55103B47.4070604@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 03/16/2015 03:16 PM, Javier Martinez Canillas wrote:
> Andrzej,
> 
> I looked at the Exynos5250 manual and I didn't find anything obvious
> that is missing in the DISP1 pd dev node but the asynchronous bridges
> clocks needed on Exynos5420 was also not well documented so I don't
> know if I'm missing something.
> 
> Do you know what could be missing here? Otherwise I think your patch
> to add the DISP1 pd in the DT should be reverted to have display
> working again on Exynos5250 boards.
> 

I wasn't able to find what's missing in the DISP1 pd definition so posted
a revert [0] to "ARM: dts: add display power domain for exynos5250".

Kukjin,

Please ignore $subject and pick [0] instead.

This will avoid Snow and Spring display to stop working and later the PD
can be added again once we know what was missing there.

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/3/23/224
