From: dsd@laptop.org (Daniel Drake)
Date: Mon, 1 Jul 2013 20:27:33 -0600
Subject: [PATCH] mmp: irq: Don't clear unused interrupt enable bits
In-Reply-To: <CAMPhdO8jAN5kCT_tgH4NxTJ=GOGQqXukUrxNWsHExUSXZ+44bA@mail.gmail.com>
References: <20130627175118.8A9FEFAACF@dev.laptop.org>
 <CAMPhdO_Ccp_JeuNNkqP6Q+ubmG8rah_hkxFJmOBsetysu-+dNw@mail.gmail.com>
 <CAMLZHHSS75dSd_PM5-Gu2K-kP+RF0Fx1E+TL=d-TeXzYSLsQPg@mail.gmail.com>
 <CAMPhdO8jAN5kCT_tgH4NxTJ=GOGQqXukUrxNWsHExUSXZ+44bA@mail.gmail.com>
Message-ID: <CAMLZHHTa18d7+Vtw9UiZrKqdw2xhWjkntYUOX56U0iwV2GLmhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 10:55 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> I'm fine with leaving these bits out as your patch does, the only concern
> is some other code may have a chance to depend on this, and may
> benefit from this boot configuration flexibility as well.

I would prefer to leave them out for simplicity of the driver.
However, I'm happy to weigh in if/when any future need comes up where
Linux needs to be directly involved with SP setup.

Daniel
