From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 19 Feb 2014 13:27:15 +0100
Subject: [PATCH] PM / Sleep: Set pm_generic functions to NULL for
 !CONFIG_PM_SLEEP
In-Reply-To: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org>
References: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140219122715.GB32069@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2014-02-19 13:09:21, Ulf Hansson wrote:
> Previously only a subset of the functions were defined and set to NULL
> while !CONFIG_PM_SLEEP. Let's make them all available so they can be
> used no matter of CONFIG_PM_SLEEP or not.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
