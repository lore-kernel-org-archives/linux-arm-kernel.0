From: gpkulkarni@gmail.com (Ganapat Rao P Kulkarni)
Date: Thu, 12 Dec 2013 13:18:19 +0530
Subject: ARM64: Domain Equivalent support in ARMv8
In-Reply-To: <CAFpQJXXpO7NmtHJoU0uHYQ_BPQqS+qn3ZgZcQkckWDv1ZjBtTQ@mail.gmail.com>
References: <CAFpQJXXpO7NmtHJoU0uHYQ_BPQqS+qn3ZgZcQkckWDv1ZjBtTQ@mail.gmail.com>
Message-ID: <CAFpQJXVsuT2XU4F9FmQbqYm-82Qbs-yVCD+N+Qc7eY-z-h1NJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will/Catalin,

The requirement what i posted is doable on ARMv8?
If yes, can you please suggest the way to do it!

regards
Ganapat

On Tue, Dec 10, 2013 at 1:17 PM, Ganapat Rao P Kulkarni
<gpkulkarni@gmail.com> wrote:
> Hi,
>
> I want to make kernel code ( all sections/blocks mapped to kernel
> code) as RO and change to R/W,  when ever hot-patch of kernel code is
> required.
> Also, R/W access changes should be available/visible to the core which
> sets R/W and all other cores continue to have RO access.
>
> This was easily done using Domain feature(by making Kernel Domain as
> Manager, using DACR) on ARMv7.
> However, on ARMv8, i see there is no domain support(in AARCH64) and
> not able to find the alternative optimal way.
>
> please suggest/share, if you have any ideas to do so.
>
> regards,
> Ganapat



-- 
regards,
Ganapat
