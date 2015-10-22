From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Oct 2015 14:57:13 +0200
Subject: [PATCH 01/13] ARM: add some L220 DT settings
In-Reply-To: <20151015135730.GC32532@n2100.arm.linux.org.uk>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-2-git-send-email-linus.walleij@linaro.org>
 <20151015135730.GC32532@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaQxbvtdrX4Vat4mJ1gRORCWjwReeAyjafnK5_mLAL1nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 3:57 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 15, 2015 at 03:46:41PM +0200, Linus Walleij wrote:

>> +- arm,eventmon-enable : enable the event monitor on the L2 cache (PL220 only).
>
> I don't think we should introduce a DT property for this: if we support
> the event monitor, then the event monitor support code should be
> controlling this bit.

OK that's reasonable. I'll make a patch for the parity enable and think
about how to implement eventmonitor bit setting.

Yours,
Linus Walleij
