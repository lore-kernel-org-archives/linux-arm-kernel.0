From: davidb@codeaurora.org (David Brown)
Date: Fri, 7 Sep 2012 15:58:53 -0700
Subject: [PATCH 8/9] ARM: msm: Add DT support for 8960
In-Reply-To: <1346873339-10927-9-git-send-email-sboyd@codeaurora.org>
References: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
 <1346873339-10927-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120907225853.GA21585@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 12:28:58PM -0700, Stephen Boyd wrote:

> +DT_MACHINE_START(MSM8960_DT, "Qualcomm MSM (Flattened Device Tree)")

The description string should specify the general name of what this is
suspporting.  Right now, with these patches, it would list

  Qualcomm MSM (Flattened Device Tree)

twice as the two targets we support (and isn't helpful when you see
which one it picks).  I'd put the "MSM" name by itself without
thinking about it too much.  It wasn't that confusing, since there was
only one at the time.

Perhaps make the 8660 one "Qualcomm MSM8660 (Flattened Device Tree)"
and the 8960 one "Qualcomm MSM8960 (Flattened Device Tree)"

I realize that the chip numbers are a bit confusing, so probably best
to pick a canonical name for the description.

David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
