From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 1 Sep 2016 10:42:04 +0800
Subject: [PATCH v2 3/7] dts: sun8i-h3: add i2c0/i2c1 SoC peripherals
In-Reply-To: <1472671858-29220-4-git-send-email-jorik@kippendief.biz>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
 <1472671858-29220-4-git-send-email-jorik@kippendief.biz>
Message-ID: <CAGb2v66c8uFHUtVtHOZCfxDEEgG7CzZgBRKWMUQS7NTizF6jyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 3:30 AM,  <jorik@kippendief.biz> wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
>
> This enables the i2c0/i2c1 peripherals of the SoC. There is actually a third
> controller, but I do not have a board on hands on which i2c2 is exposed in such
> a way that I can verify that it works.

If they are listed in the manual, and the interrupts, clocks, resets, pins
all exist, that is good enough for me.

>
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
