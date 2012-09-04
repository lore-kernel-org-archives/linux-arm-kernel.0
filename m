From: davidb@codeaurora.org (David Brown)
Date: Tue, 4 Sep 2012 16:21:11 -0700
Subject: [PATCHv2] ARM: msm: Implement read_current_timer for msm timers
In-Reply-To: <1346371222-7450-1-git-send-email-sboyd@codeaurora.org>
References: <1346371222-7450-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120904232111.GA7598@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 05:00:22PM -0700, Stephen Boyd wrote:
> Setup the same timer used as the clocksource to be used as the
> read_current_timer implementation. This allows us to support a
> stable udelay implementation on MSMs where it's possible for the
> CPUs to scale speeds independently of one another.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: David Brown <davidb@codeaurora.org>

Will, let me know if you'd prefer that I pull this.

David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
