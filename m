From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 19 Oct 2018 09:16:56 -0700
Subject: [PATCH v2 1/9] ASoC: sun4i-i2s: Add compatibility with A64 codec
 I2S
In-Reply-To: <2698773.RERkv2aHyz@anarsoul-thinkpad>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-2-anarsoul@gmail.com>
 <20181015081836.onjczcsg5qwp6rbt@flea> <2698773.RERkv2aHyz@anarsoul-thinkpad>
Message-ID: <CA+E=qVfRzWYELnvkV+5sq8mDOCMF49Ng0eU57qRQyZadHGQ3Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 9:14 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Monday, October 15, 2018 1:18:36 AM PDT Maxime Ripard wrote:
> > On Sat, Oct 13, 2018 at 09:53:21AM -0700, Vasily Khoruzhick wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > The I2S block used for the audio codec in the A64 differs from other 3
> > > I2S modules in A64 and isn't compatible with H3. But it is very similar
> > > to what is found in A10(sun4i). However, its TX FIFO is
> > > located at a different address.
> > >
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Mark, can you pick this patch up please?

Ooops, wrong patch, please ignore this message.

>
> Thanks!
>
> Regards,
> Vasily
>
> >
> > Maxime
>
>
>
>
