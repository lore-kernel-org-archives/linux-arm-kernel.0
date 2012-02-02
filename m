From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 2 Feb 2012 16:55:43 +0530
Subject: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
In-Reply-To: <20120202093600.12509.35052.stgit@dusk>
References: <20120202093600.12509.35052.stgit@dusk>
Message-ID: <CAMQu2gyKEFHAXYyhv=a6NW-AMsDHkBy+bYmhQ5ryJCQK_d_RBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2012 at 3:08 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> This series consolidates some duplicated PM code across OMAP2, 3, and 4.
> This saves both binary kernel image size, and lines of source. ?These
> functions are just the low-hanging fruit; it looks to me like there's even
> more consolidation that could be done.
>
> Suspend + UART wakeup was tested on OMAP44xx BeagleBoard. ?On the
> OMAP35xx Beagleboard here, v3.3-rc2 doesn't seem to wake up from
> suspend correctly with or without these patches, so I've only boot-tested
> them on that platform.
>
Thanks for patches. Tried them on OMAP4 SDP and suspend
is fine on it.

On the consolidation front, I found that OMAP4/OMAP5
can almost share most of the PRCM code.
Actually it's too early to talk about OMAP5 patches, which are not even posted
yet but just thought of mentioning that on this relevant thread.

I can send you a git link to have early preview on those changes, if you
would like to have a look at it.

Regards
Santosh
