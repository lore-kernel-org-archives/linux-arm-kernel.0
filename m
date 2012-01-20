From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Jan 2012 10:18:03 +0000
Subject: [PATCH] ARM: cache-l2x0.c: consistently use u32
In-Reply-To: <E1RoBA7-0005Jg-OU@rmk-PC.arm.linux.org.uk>
References: <E1RoBA7-0005Jg-OU@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHkRjk7xVxU1ZY4nZe-9BR0EfK=WCt5xzT5QAS-nafU9_94r3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 09:53, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> __u32 exists to avoid namespace clashes with userspace programs. ?It
> should not be used outside header files, so convert to use u32 instead.
> Also, don't mix uint32_t and __u32 - use the same type throughout the
> file for consistency.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

As some of this code was probably mine:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
