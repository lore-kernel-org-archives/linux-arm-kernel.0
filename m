From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Oct 2013 09:28:48 -0700
Subject: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CACRpkdbKk=n=6tU=9fD05Gu9utpQSZ1qrK7EqLf5qwaV7eHBWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 4:46 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> If you believe the issue should be solved in a different way (for instance by
> removing the architecture dependency completely) please reply to the cover
> letter to let other maintainers chime in.

I have no real opinions on whether this is a good itermediate step towards
complete arch-independence or not, but I just noticed that you still
have the <mach/*> hierarchy in mach-shmobile/include/mach/*, and
grep:ing around this seems totally unnecessary, I think it would be
easy to produce a patch set eliminating <mach/*> from shmobile.

(Usually we will just move all the headers down into the
mach-shmobile folder.)

Yours,
Linus Walleij
