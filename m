From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 12 Oct 2018 21:21:02 -0700
Subject: [alsa-devel] [PATCH 03/10] ASoC: sun8i-codec: add support for
 speaker amp GPIO
In-Reply-To: <CAGb2v66sfw6AQFjCjDA5JwYsE4zOaKjxjSLX5J8vq=wZrdHDVw@mail.gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
 <20181013033230.6506-4-anarsoul@gmail.com>
 <CAGb2v66sfw6AQFjCjDA5JwYsE4zOaKjxjSLX5J8vq=wZrdHDVw@mail.gmail.com>
Message-ID: <CA+E=qVeS4hhwFiu-Q939R6DLcf0aZg2SnMB6KZ0kvsC8kRgMiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 9:00 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sat, Oct 13, 2018 at 11:33 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > Some boards may have external amplifier for speaker that is controlled
> > via GPIO, add support for it in similar way as it's done in sun4i-codec
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> ASoC now has a generic amplifier driver. Please use that instead.
>
> See Documentation/devicetree/bindings/sound/simple-amplifier.txt

Is there any example on how to use it? Documentation doesn't specify
what DAPM routes I have to add to get it working.

>
> ChenYu
