From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 15 Sep 2011 16:38:57 +0200
Subject: [PATCH 2/2] ARM: mmp: add audio sram allocator
In-Reply-To: <1312167547-26740-3-git-send-email-leoy@marvell.com>
References: <1312167547-26740-1-git-send-email-leoy@marvell.com>
	<1312167547-26740-3-git-send-email-leoy@marvell.com>
Message-ID: <20110915143857.GL28104@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:59 Mon 01 Aug     , Leo Yan wrote:
> Implement the audio sram allocator with genalloc,
> so that can dynamically allocate the buffer
> to pcm devices as need.
> 
> Signed-off-by: Leo Yan <leoy@marvell.com>
this can be more generic nad move to lib/genalloc.c

Best Regards,
J.
