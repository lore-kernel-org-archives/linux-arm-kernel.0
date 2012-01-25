From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Jan 2012 11:33:27 +0000
Subject: [PATCH 4/5] ARM: pgtable: provide get_top_pte() to complement
 set_top_pte()
In-Reply-To: <E1RoBpD-0005og-Hf@rmk-PC.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
 <E1RoBpD-0005og-Hf@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHkRjk7+pf3ZhYAO7EV1OBKgJcKTv-tZtXTw3N2MMgWnHM0P-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 10:36, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Provide get_top_pte() to complement set_top_pte(), moving the only
> users of TOP_PTE to arch/arm/mm/mm.h.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
