From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 1 May 2018 16:10:36 +0300
Subject: [PATCH 1/1] mfd: tps65911-comparator: Fix an off by one bug
In-Reply-To: <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
References: <20180501094553.31545-1-lee.jones@linaro.org>
 <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
Message-ID: <20180501131036.bm7rcujohxi5devs@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The background is that no one noticed that this driver stopped being
buildable in 2012 until I fixed it last week.  This is the third
proposed patch to fix the off by one.  All three patches fix the bug,
but Lee refused to accept my style and I refused to use Lee's style...
Absolutely *no way*!  LOL.  But really neither of us take it personally
and we've met in person before and collaborate over email and get along.

This thread has been pretty amusing for me, but let's move on.  :P

regards,
dan carpenter
