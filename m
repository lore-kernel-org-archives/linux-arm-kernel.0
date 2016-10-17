From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Mon, 17 Oct 2016 11:22:46 +0200
Subject: [PATCH 06/10] mm: replace get_user_pages() write/force
 parameters with gup_flags
In-Reply-To: <20161013002020.3062-7-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-7-lstoakes@gmail.com>
Message-ID: <20161017092246.GG30704@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2016 at 01:20:16AM +0100, Lorenzo Stoakes wrote:
> This patch removes the write and force parameters from get_user_pages() and
> replaces them with a gup_flags parameter to make the use of FOLL_FORCE explicit
> in callers as use of this flag can result in surprising behaviour (and hence
> bugs) within the mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/cris/arch-v32/drivers/cryptocop.c                 |  4 +---

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
