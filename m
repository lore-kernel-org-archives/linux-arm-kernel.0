From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 May 2013 13:57:33 +0200
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <20130528162715.GB28253@arwen.pp.htv.fi>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
 <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
 <20130528162715.GB28253@arwen.pp.htv.fi>
Message-ID: <CACRpkdZn14Gn-YEeHJHre6Sr4JU-xjOeLFgM8OjX7M5qnKudTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 6:27 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, May 15, 2013 at 07:18:01PM +0200, Linus Walleij wrote:

>> I can't merge any of this without Felipes ACKs in any
>> case.
>
> Do you want to take this yourself ? I haven't fully read the series yet,
> but seems like this depends on the rest of the series. If you want to
> take it, let me know I can ack the patches as soon as I'm done
> reviewing.

Yes please. They are dependent on a stash of patches that that
has recently landed in the ARM SoC tree, so currently they need
to follow those through the same tree, which is where I funnel
all the ux500 stuff.

Yours,
Linus Walleij
