From: takashi.yoshii.zj@renesas.com (takashi.yoshii.zj at renesas.com)
Date: Thu, 29 Aug 2013 16:08:27 +0900
Subject: [PATCH] arm: Prevent memory aliasing on non-LPAE kernels
In-Reply-To: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
References: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <20130829160827.5c13ad5af24a4d85c4df2eef@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stepan,
What is the status of this fix?

I am looking forward it to be merged, but it seems not have happend, yet.
Are you waiting for it to be merged, too? or planning to post v2?
# IMHO, v2 is not needed. Checked conditions and places are reasonable.

I just confirmed on 3.11-rc7, that
- The issue still exists.
- This patch can be applied cleanly, and fixes the issue.

Thanks,
/yoshii
