From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Oct 2018 12:00:19 +0800
Subject: [alsa-devel] [PATCH 03/10] ASoC: sun8i-codec: add support for
 speaker amp GPIO
In-Reply-To: <20181013033230.6506-4-anarsoul@gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
 <20181013033230.6506-4-anarsoul@gmail.com>
Message-ID: <CAGb2v66sfw6AQFjCjDA5JwYsE4zOaKjxjSLX5J8vq=wZrdHDVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2018 at 11:33 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Some boards may have external amplifier for speaker that is controlled
> via GPIO, add support for it in similar way as it's done in sun4i-codec
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

ASoC now has a generic amplifier driver. Please use that instead.

See Documentation/devicetree/bindings/sound/simple-amplifier.txt

ChenYu
