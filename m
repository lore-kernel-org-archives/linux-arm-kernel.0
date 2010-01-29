From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Jan 2010 07:49:21 +0100
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129064920.GB1529@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2010-01-28 14:59:29, Daniel Walker wrote:
> From: Willie Ruan <wruan@quicinc.com>
> 
> The application processor in Qualcomm's MSM chips can be powered off
> (also called power collapse) during suspend and idle time. L2 cache power
> will be collapsed too on current chips. To handle this scenario, we need
> to add a function (l2x0_suspend here) to flush L2 cache before the power
> loss and another function (l2x0_resume) to restore the cache settings
> after the power is restored.

So this fixes suspend/resume? Ack...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
