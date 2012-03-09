From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 9 Mar 2012 02:11:41 +0000
Subject: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <20120309011914.GF2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <4F5910EE.8090408@freescale.com>
 <20120309011914.GF2499@S2101-09.ap.freescale.net>
Message-ID: <4F5966DC.6090201@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Are you testing the patch set on top of the SHA below, which I
> mentioned in the cover letter?
>
>    3030763 (Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into topic/asoc)
>
> I see the similar problem on the following SHA with my testing on
> imx-sgtl5000.
>
>    1a8feca (Merge branch 'for-3.4' into asoc-next)

It appears the problem is with for-3.4 itself.  I'm running git-bisect now 
to narrow it down.

-- 
Timur Tabi
Linux kernel developer at Freescale
