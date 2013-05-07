From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Tue, 7 May 2013 17:31:31 +0200
Subject: [PATCH] proc: Use PDE attribute setting accessor functions
In-Reply-To: <1367918426-7076-1-git-send-email-geert@linux-m68k.org>
References: <1367918426-7076-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20130507153131.GP8853@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 11:20:26AM +0200, Geert Uytterhoeven wrote:
> arch/arm/mach-msm/last_radio_log.c: In function 'msm_init_last_radio_log':
> arch/arm/mach-msm/last_radio_log.c:69:7: error: dereferencing pointer to incomplete type
> 
> arch/cris/kernel/profile.c: In function 'init_cris_profile':
> arch/cris/kernel/profile.c:79:8: error: dereferencing pointer to incomplete type
> 
> Use proc_set_size(), cfr. commit 271a15eabe094538d958dc68ccfc9c36b699247a
> ("proc: Supply PDE attribute setting accessor functions")
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

For the CRIS-part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
