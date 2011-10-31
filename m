From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 31 Oct 2011 08:48:33 +0000
Subject: Serious question: How long does it take to get 64bit into ARM?
In-Reply-To: <20111030001654.GX4267@michelle1>
References: <20111030001654.GX4267@michelle1>
Message-ID: <CAHkRjk47P4BpEWCRAyU_cJ=nA1s+-Xbe2+WAwJ9LMx5-wJ6KkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30 October 2011 01:16, Michelle Konzack
<linux4michelle@tamay-dogan.net> wrote:
> Applied Micro Circuits (AMCC) has now presented its new 64bit ARM ?C:
>
> ? ?<http://www.pcmag.com/article2/0,2817,2395449,00.asp>
>
> and I like to know, how long it take, to ?get ?64bit ?support ?into ?the
> Kernel.

We are working on this already and will follow the Linux community
review process to get the ARMv8 support in the mainline kernel. I
can't mention a timeline at this point as it depends on detailed
documentation being available and at least some early hardware (FPGA)
to test on but hopefully we'll complete the process before you can get
platforms with ARMv8 (even if mainline would not fully support ARMv8,
I'll make patches available on some Git tree).

-- 
Catalin
