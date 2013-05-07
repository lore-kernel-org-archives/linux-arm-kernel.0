From: dhowells@redhat.com (David Howells)
Date: Tue, 07 May 2013 10:37:30 +0100
Subject: [PATCH] proc: Use PDE attribute setting accessor functions
In-Reply-To: <1367918426-7076-1-git-send-email-geert@linux-m68k.org>
References: <1367918426-7076-1-git-send-email-geert@linux-m68k.org>
Message-ID: <23761.1367919450@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

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

Acked-by: David Howells <dhowells@redhat.com>
