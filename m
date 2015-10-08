From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 8 Oct 2015 11:25:41 +0100
Subject: [PATCH] KVM: arm/arm64: Add VGICv3 save/restore API documentation
In-Reply-To: <005e01d101a9$31ee80f0$95cb82d0$@samsung.com>
References: <1444247430-14808-1-git-send-email-christoffer.dall@linaro.org>
 <003a01d10199$58e96590$0abc30b0$@samsung.com> <20151008082302.GE14315@cbox>
 <005e01d101a9$31ee80f0$95cb82d0$@samsung.com>
Message-ID: <CAFEAcA-3vUgB=LCsiEwGoM0G28yszw+90LFajOB8akgwiQwuuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2015 at 10:10, Pavel Fedin <p.fedin@samsung.com> wrote:
>  Sorry, didn't want to offend anyone. I just wanted to tell that i know
> that you, as maintainers, have much more power than i do, and you can
> always say "it's political decision, we just want it and that's final",
> and if you choose to do this, i'm perfectly OK with that, just say it.

This isn't intended to be a political decision; it's our joint
technical opinion on the best design for this API. Since we all
happened to be in one physical location the other week it was a good
opportunity for us to work through how we thought the API should
look from a technical perspective. At that point it seemed to us
to be clearer to write up the results of that discussion as a
single patch to the API documentation, rather than doing it by
(for instance) making lots of different review comments on your patches.
Christoffer's API documentation patch is a patch like any other and
it has to go through review. If there are parts where you don't
understand the rationale or you think we got something wrong you
should let us know.

thanks
-- PMM
