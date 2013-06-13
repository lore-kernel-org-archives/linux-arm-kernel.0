From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Jun 2013 10:41:54 +0200
Subject: [PATCH 00/32] ARM: ux500: Enable clocks for Device Tree
In-Reply-To: <20130612132713.GE4320@laptop>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <20130612132713.GE4320@laptop>
Message-ID: <CACRpkdYtocMN-qvhOX_uHw=zoJysjJhGjQv5gL_ijkR56QL4Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 3:27 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> After this patchset has been applied, we can request clocks directly
>> from Device Tree without using any AUXDATA device-name hacks. We also
>> take care to remove all of thos at the end of the set.
>
> So it looks like Mike and Grant have okayed the actual design of this
> patch-set, which is great. Is there any chance on some proper Acks from
> Linus and Mike please?

I will get to it. Basically I don't see there is a hurry as this has
no chance to hit the v3.11 merge window anyway so we'll have
lots of time to discuss it.

Why 3.12: my five pull request for ux500 stuff to ARM SoC is still
outstanding, and this stuff will clash with that unless we get
a common merge base. So we have to wait for ARM SoC
to settle at this point.

Yours,
Linus Walleij
