From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2011 19:27:22 +0200
Subject: [PATCH 4/4] davinci: create new common platform header for davinci
In-Reply-To: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
References: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <201105201927.22386.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 May 2011 16:14:01 Manjunath Hadli wrote:
> remove the code from individual platform header files for
> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file dmx.h.
> Include the new header file in individual platform header
> files as a pre-cursor for deleting these headers in follow
> up patches.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>

I probably missed the discussion that led to this patch, but
please explain the motivation behind the change in the changelog.

Your current changelog reads like this is pointless churn,
which may or may not be the case. The diffstat shows 27 lines
being removed in total, which is roughly the amount of copyright
headers.

	Arnd
