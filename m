From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Feb 2015 21:03:02 +0100
Subject: [PATCH v3] mmc: moxart: fix probe logic
In-Reply-To: <1422891786-23071-1-git-send-email-jonas.jensen@gmail.com>
References: <4754899.RDUhFfxBSW@wuerfel>
 <1422891786-23071-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <6294882.EhDcdWGRYz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 February 2015 16:43:06 Jonas Jensen wrote:
> 
> Notes:
>     This is a forward (with a single line fix) of Arnd's v2 patch.
>     
>     v2:  do not call clk_put() on an error pointer
>     v3:  fix NULL dereference on host->clk
>     
>     Applies to next-20150113

Thanks for forwarding the fixed version. I just realized that you
probably haven't forwarded a lot of patches from other people, so you
missed two things:

- to preserve patch ownership, the first line (before the rest of the
description) should be 'From: Arnd Bergmann <arnd@arndb.de>'

- It is common to include the entire signoff chain, which in this case
is my Signed-off-by on one line, followed by yours on the next line
at the end of the description.

Ulf can probably fix this up when he applies the patch, or you can
send it again to be sure.

	Arnd
