From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 18 Sep 2011 02:47:55 +0200
Subject: [PATCH 2/2] ARM: mmp: add audio sram allocator
In-Reply-To: <4E72A2A1.1020400@marvell.com>
References: <1312167547-26740-1-git-send-email-leoy@marvell.com>
	<1312167547-26740-3-git-send-email-leoy@marvell.com>
	<20110915143857.GL28104@game.jcrosoft.org>
	<4E72A2A1.1020400@marvell.com>
Message-ID: <20110918004755.GD16141@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:13 Fri 16 Sep     , Leo Yan wrote:
> 
> 
> On 09/15/2011 10:38 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 10:59 Mon 01 Aug     , Leo Yan wrote:
> >>Implement the audio sram allocator with genalloc,
> >>so that can dynamically allocate the buffer
> >>to pcm devices as need.
> >>
> >>Signed-off-by: Leo Yan<leoy@marvell.com>
> >this can be more generic nad move to lib/genalloc.c
> 
> This is an older version, i have updated the patch same as you said.
> pls see below link for the latest patch:
> http://lists.arm.linux.org.uk/lurker/message/20110815.030920.2ad4227b.en.html
I take a look on it it's the same issue this is not mach specific

Best Regards,
J.
