From: tetra2005@gmail.com (Yuri Gribov)
Date: Thu, 10 Jul 2014 00:40:58 +0400
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <87pphenxex.fsf@tassilo.jf.intel.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
 <87pphenxex.fsf@tassilo.jf.intel.com>
Message-ID: <CAJOtW+5=5EGwLyAA+33y4E9UGuGHuXQkf6rTEsh0e7rqoNBKCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 11:29 PM, Andi Kleen <andi@firstfloor.org> wrote:
> Hardcoding --param is not very nice. They can change from compiler
> to compiler version. Need some version checking?

We plan to address this soon. CFLAGS will look more like
-fsanitize=kernel-address but this flag is not yet in gcc.

-Y
