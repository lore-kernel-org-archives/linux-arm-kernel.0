From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Jan 2012 11:20:57 +0000
Subject: [PATCH 1/5] ARM: pgtable: move TOP_PTE address definitions to
 arch/arm/mm/mm.h
In-Reply-To: <E1RoBoE-0005oQ-Hf@rmk-PC.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
 <E1RoBoE-0005oQ-Hf@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHkRjk7XmGxEHYNGCx-B0W2SYLNr3LKY9PP+bDv1ZgUR6i=NyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 10:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Move the TOP_PTE address definitions to one central place so that it's
> easy to discover what they're being used for. ?This helps to ensure
> that there are no overlaps.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
