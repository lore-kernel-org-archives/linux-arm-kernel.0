From: jrnieder@gmail.com (Jonathan Nieder)
Date: Fri, 3 Sep 2010 18:32:52 -0500
Subject: [bug-patch] [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <201009040058.18028.agruen@suse.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<201009040058.18028.agruen@suse.de>
Message-ID: <20100903233252.GD30310@burratino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas Gruenbacher wrote:

> something pretty bizarre is going on here.  The wget output modifies the same 
> file twice, but both patches to this file have the same source sha1 (5645f35):
