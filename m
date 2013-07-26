From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 26 Jul 2013 12:54:14 -0700
Subject: [GIT PULL] arm64 fixes for 3.11
In-Reply-To: <20130726155458.GA31613@arm.com>
References: <20130726155458.GA31613@arm.com>
Message-ID: <CA+55aFzmEhGvqY883Bg568Gguewy41X9n1qDeaHkW2We6VVhZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 8:55 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> - Stack size increased to 16K (similar to other 64-bit architectures)

I pulled, but this is misleading.

*Some* other 64-bit architectures do 16k stack sizes. But neither
x86-64 nor powerpc do, afaik. Instead, they do irq stacks, which is
generally a better idea than having one big stack.

                Linus
