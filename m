From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Mar 2018 09:33:28 +0100
Subject: [PATCH] drm/bridge: sii902x: Retry status read after DDI I2C
In-Reply-To: <20180305160551.GD16053@e110455-lin.cambridge.arm.com>
References: <20180305101702.13441-1-linus.walleij@linaro.org>
 <20180305160551.GD16053@e110455-lin.cambridge.arm.com>
Message-ID: <CACRpkdb7__0iLXPgzR0fBX+-2PTMtbAoicfHGkAuW4nxi58RWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 5:05 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:

>> Cc: Ville Syrj?l? <ville.syrjala@linux.intel.com>
>> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
>
> I don't have a suitable configuration to test this, but looks goot to me.
>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks!

> BTW, Linus, could it be that your DVI-to-VGA connector doesn't wire
> correctly the EDID pin?

Very possible. I also suspect signal levels or something like
that, possibly no proper pull-up resistor on the line. Or
anything similar... it now falls back nicely to default EDID
modes though.

Yours,
Linus Walleij
