From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 12 Jul 2013 22:16:32 +0530
Subject: [PATCH] ARM: davinci: make file local variables static
In-Reply-To: <1373627957-12979-1-git-send-email-nsekhar@ti.com>
References: <1373627957-12979-1-git-send-email-nsekhar@ti.com>
Message-ID: <CA+V-a8tYgtdUp0FwrJ49r0YhnJUt=E=e2-=uCxPhTK=R-uc9bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 4:49 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> Make file local variables static in mach-davinci.
> This fixes sparse warnings of the form:
>
> arch/arm/mach-davinci/dm355.c:863:27: warning: symbol 'dm355_venc_pdata' was not declared. Should it be static?
>
> Cc: Prabhakar Lad <prabhakar.csengg@gmail.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
