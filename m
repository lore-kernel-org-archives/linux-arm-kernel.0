From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 6 Nov 2009 12:19:37 +0900
Subject: [PATCH 03/17] ARM: S5PC1XX: clock registers rename
In-Reply-To: <1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091106031937.GH3913@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:11:08AM +0200, Marek Szyprowski wrote:
> S5PC100 and S5PC110 clock registers differs in many places, rename all
> previously defined registers to be S5PC100 specific. Remove all power
> management registers. They will be added later to a separate file.

This looks good to me. Not that I have any authority, I'm just reviewing.
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
