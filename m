From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 19:37:02 -0700
Subject: [GIT PULL] at91: soc updates for 3.11 #1
In-Reply-To: <1371246138-22207-1-git-send-email-nicolas.ferre@atmel.com>
References: <1371246138-22207-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130615023702.GA8635@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 14, 2013 at 11:42:18PM +0200, Nicolas Ferre wrote:
> Arnd, Olof,
> 
> A little AT91 pull-request for patches that are more targeted to SoC/boards
> modifications. It is prepared on top of the arm-soc/at91/cleanup branch.
> 
> Thanks, best regards,
> 
> The following changes since commit b3f442b0eedbc20b5ce3f4a96530588d14901199:
> 
>   ARM: at91: udpate defconfigs (2013-05-17 15:05:08 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-soc
> 
> for you to fetch changes up to 7e75545ea7fb972c3da759f92c3d0be84d1cee72:
> 
>   ARM: at91: drop rm9200dk board support (2013-06-14 23:34:11 +0200)
> 
> ----------------------------------------------------------------
> Two non critical fixes that can go in 3.11.
> An old board removed.
> 
> ----------------------------------------------------------------
> Alexandre Belloni (1):
>       ARM: at91: Fix link breakage when !CONFIG_PHYLIB

Fix

> Jean-Christophe PLAGNIOL-VILLARD (1):
>       ARM: at91: drop rm9200dk board support

Cleanup

> Wenyou Yang (1):
>       ARM: at91: Change the internal SRAM memory type MT_MEMORY_NONCACHED

Fix

...assuming, of course, that none of the fixes are for errors introduced in
some branch we already pulled, since then they should go on top of that branch.


-Olof
