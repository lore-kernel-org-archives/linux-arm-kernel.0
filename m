From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Sep 2011 12:54:03 +0200
Subject: [PATCH 0/2] pin controller subsystem v7
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B73216C5@HQMAIL01.nvidia.com>
References: <1316175182-10700-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73216C5@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdasYEFvJu0VhjGRTp2k2JupcWsrJ17g7fcrKXKphP3Zww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:10 PM, Stephen Warren <swarren@nvidia.com> wrote:

> ... hence I was surprised to see that you explicitly note that mapping a
> single device to multiple controllers was disallowed.

Actually it's easy to fix, I mainly wanted to keep that until we have
a solid usecase for it, it's just a few lines of code the day we
need it.

> Then again, if this need ever does arise, we should be able to just relax
> this restriction without causing any backwards-compatibility issues, so
> I don't see a specific need to change this now; I just thought I'd mention
> it so you're aware of what I'm thinking.

It was actually on my mind, I just wanted to keep down the feature
creep to what was absolutely needed for the pin controllers we're
facing in arch/arm/* today.

Thanks!
Linus Walleij
