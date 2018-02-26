From: greg@kroah.com (Greg KH)
Date: Mon, 26 Feb 2018 11:05:18 +0100
Subject: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
 <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
Message-ID: <20180226100518.GA11378@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 04:20:20PM +0800, Alex Shi wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> ** Not yet queued for inclusion in mainline **

As Marc said, this should have been a HUGE clue that we can't take this
patch.  Please go re-read
	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

thanks,

greg k-h
