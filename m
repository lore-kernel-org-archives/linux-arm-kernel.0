From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 11:30:28 +0200
Subject: [PATCH 1/5] gpio: pxa: remove dead code
In-Reply-To: <51F0E92E.6060900@gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
 <1373555877-29887-2-git-send-email-zonque@gmail.com>
 <CACRpkdaB7JnWzoLKpQ1eLWAi7yFz9CanhbhwtiCnEtcNWzX3RQ@mail.gmail.com>
 <CAD6h2NS0p-kMUGyhbr93vd_oLSNyaB572riFB8mHt1cu5f-bGw@mail.gmail.com>
 <51F0E92E.6060900@gmail.com>
Message-ID: <CACRpkdZT51uwW6z-BzmU2tv9-fX=UQN2ywCQwb-SDVHovo4BxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:00 AM, Daniel Mack <zonque@gmail.com> wrote:

> And what about the others? I think the first 3 patches of this series
> can go through Linus W, and the other 2 should end up in the pxa tree,
> right?

Yes. They might need to build on top of the pinctrl tree.

Or, if there are no other things happening in the PXA tree for the
next merge window, I can take it into my tree, with the ACKs of
e.g. Eric and Olof Johansson.

Yours,
Linus Walleij
