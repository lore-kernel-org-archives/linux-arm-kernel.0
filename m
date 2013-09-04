From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 04 Sep 2013 14:58:41 -0700
Subject: [PATCH 0/3] ARM: PCI: versatile: fix irqs, I/O
In-Reply-To: <CACRpkdYZiTRkivBY6ZsroOce9Oj=R86x3q0Pw9G4X=gUWyL6bw@mail.gmail.com>
 (Linus Walleij's message of "Wed, 28 Aug 2013 21:13:36 +0200")
References: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
 <CACRpkdYZiTRkivBY6ZsroOce9Oj=R86x3q0Pw9G4X=gUWyL6bw@mail.gmail.com>
Message-ID: <87ppsont9q.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Thu, Aug 22, 2013 at 6:47 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> These patches fix a number of issues with the PCI controller
>> code for mach-versatile:
>
> All seem sound to me.
>
> Please mark all as Cc: stable at vger.kernel.org
> and push the ARM SoC maintainers to take these three
> patches as fixes.

I've picked these up and added the Reviewed-by from Linus and the Cc:
stable.

They will not likely get into the v3.12 merge window, but will get them
in during the v3.12-rc

Thanks for the fixes,

Kevin
