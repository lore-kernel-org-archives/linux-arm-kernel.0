From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Dec 2011 22:50:39 +0100
Subject: [PATCH] ARM: drop unused parameter from flush_cache_user_range
In-Reply-To: <1323985698-6371-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323985698-6371-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111215215039.GI24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 10:48:18PM +0100, Uwe Kleine-K?nig wrote:
> vma isn't used and flush_cache_user_range isn't a standard macro that
> is used on several archs with the same prototype. In fact only unicore32
> has a macro with the same name (with an identical implementation and no
> in-tree users).
> 
> This is a part of a patch proposed by Dima Zavin (with Message-id:
> 1272439931-12795-1-git-send-email-dima at android.com) that didn't get
> accepted.
> 
> Cc: Dima Zavin <dima@android.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
Hello,

oh I forgot to add

	From: Dima Zavin <dima@android.com>

This was done by mistake and not to hijack authorship.

Sorry
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
