From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 15 Oct 2010 15:49:49 +0300
Subject: [PATCH 2/2] omap: rx51: mark reserved memory earlier
In-Reply-To: <1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	<1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
Message-ID: <AANLkTinYUSqvPA1sGte0hE0jax4upRhaqJmE2w1L=d0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 3:46 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So that omap_vram_set_sdram_vram() is called before
> omap_vram_reserve_sdram_memblock().

I actually didn't test this (my battery died).

But the previous one works with CONFIG_OMAP2_VRAM_SIZE=6.

-- 
Felipe Contreras
