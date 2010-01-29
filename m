From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Jan 2010 07:55:06 +0100
Subject: [RFC PATCH 11/12] arm: vfp: Add additional vfp interfaces
In-Reply-To: <1264719577-5436-12-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-12-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129065506.GD1635@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2010-01-28 14:59:36, Daniel Walker wrote:
> From: Dave Estes <cestes@quicinc.com>
> 
> Refactor common code to vfp_flush_context() and vfp_reinit().  Allow
> use by other client beside suspend/resume.  Currently intended for
> idle power collapse.
> 
> Signed-off-by: Dave Estes <cestes@quicinc.com>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
