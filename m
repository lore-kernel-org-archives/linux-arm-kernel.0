From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 11:38:59 +0200
Subject: [RFC PATCH v3] reset: Add a defer reset object to send board
 specific reset
In-Reply-To: <20140708080535.GJ13423@lukather>
References: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
 <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
 <20140708080535.GJ13423@lukather>
Message-ID: <CACRpkdbFPAsu1gE-AVyD=-RxyE7mUJPSbFga7HLh0mxjE-mQuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 10:05 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jul 08, 2014 at 09:52:03AM +0200, Linus Walleij wrote:
>> On Wed, Jun 18, 2014 at 3:37 PM, Houcheng Lin <houcheng@gmail.com> wrote:
>>
>> > The Problem
>> > -----------
>> > The reset signal on a hardware board is send either:
>> >     - during machine initialization
>> >     - during bus master's initialization
>>
>> I just thought about this a bit, since there isn't already a generic GPIO
>> reset driver, just call this drivers/reset/reset-gpio.c and make the
>> ability to deferral just a configuration detail of the GPIO reset driver.
>
> Philipp has been working on one for quite some time. See
> http://www.spinics.net/lists/arm-kernel/msg321927.html
>
> However, it seems to progress slowly, and we don't seem to be able to
> reach a consensus here.
>
> If you ask me, having to set a few extra properties like this just
> advocates for a regular reset driver and DT node for the reset GPIO,
> but I'm pretty sure Philipp will feel otherwise :)

Hm haha yeah let's fight it out :-)

This is not my subsystem so I'm getting some popcorn.

Yours,
Linus Walleij
