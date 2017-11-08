From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Nov 2017 13:48:39 +0100
Subject: [PATCH] ARM: sa1100: simpad: Correct I2C GPIO offsets
In-Reply-To: <24888cd2-e3ef-2f34-4c0c-c7e620f5e3e0@scram.de>
References: <20171107151703.3847-1-linus.walleij@linaro.org>
 <24888cd2-e3ef-2f34-4c0c-c7e620f5e3e0@scram.de>
Message-ID: <CACRpkdY4ei8_BQG7yVKCH3ZsQisSJxdMMi=VJ9kdKULuAwEsJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 8, 2017 at 9:40 AM, Jochen Friedrich <jochen@scram.de> wrote:

>> Jochen: did this ever work? I suspect the patch was simply developed on
>> top of a different kernel.
>
> This really was developed on top of a much older kernel. I didn't test this
> for a while now as on my Simpad, the touch screen died a while ago (mainly
> returning random position data), so the device is useless...

I wonder if anyone is booting simpad on the recent kernels. Maybe it
should simply be decomissioned if there are no users.

Oh well, that is for later.

Yours,
Linus Walleij
