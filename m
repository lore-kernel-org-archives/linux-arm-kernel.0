From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 30 Nov 2012 11:18:37 -0800
Subject: [PATCH 0/6] drivers: convert struct spinlock to spinlock_t
In-Reply-To: <50B87082.3020604@broadcom.com>
References: <1354221910-22493-1-git-send-email-mcgrof@do-not-panic.com>
 <50B87082.3020604@broadcom.com>
Message-ID: <CAB=NE6UO8jPYOktteaLeihVqLp251-Q=jv5z_OThXoR+JtRKeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 12:38 AM, Arend van Spriel <arend@broadcom.com> wrote:
> So what is the rationale here. During mainlining our drivers we had to
> remove all uses of 'typedef struct foo foo_t;'. The Linux CodingStyle
> (chapter 5 Typedefs) is spending a number of lines explaining why.
>
> So is spinlock_t an exception to this rule simply because the kernel
> uses spinlock_t all over the place.

Yes.

  Luis
