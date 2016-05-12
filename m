From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2016 09:42:01 -0700
Subject: [PATCH v3 0/7] ARM/ASoC: OMAP3: Fix McBSP2/3 sidetone support
In-Reply-To: <69ff65ee-e5d1-09fb-fd91-8d7b4d8fdda4@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <69ff65ee-e5d1-09fb-fd91-8d7b4d8fdda4@ti.com>
Message-ID: <20160512164201.GQ5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160511 01:46]:
> Tony, Paul,
> 
> On 04/29/16 13:53, Peter Ujfalusi wrote:
> > Hi,
> > 
> > Based on the ongoing discussion on v2 (ARM: OMAP3: Fix McBSP2/3 hwmod setup for
> > sidetone) I have dropped the removal of the sidetone hwmod and only corrected
> > it. The series now includes all related changes needed to have correct sidetone
> > support whenever we boot in legacy or in DT mode.
> > 
> > This time the ASoC part have dependency on earlier patches so they can not be
> > applied separately.
> 
> How should we proceed from here? I don't want to start designing the ST
> separation infrastructure which would be based on this series, but if there
> are outstanding issues found on this, I would need to go back to the drawing
> board.
> The separation will be mostly new code and code shuffle in ASoC, but for
> legacy I will need to build up something in arch as well, so I would need at
> least one release cycle to start with things.

Well looks like we have all the acks, so I can apply these. We have
not heard from Paul on this for a while, so let's wait few days for
that.

Meanwhile, Mark wanted to fix the subject for one of the patches, care
to repost that at least? Or the whole series with acks, could be a
pull request too against v4.6-rc1 :)

Regards,

Tony
