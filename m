From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 5 Dec 2017 15:04:19 -0800
Subject: [PATCH 2/9] ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
In-Reply-To: <20171205080149.2siofhpynfrvnoiq@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-3-anarsoul@gmail.com>
 <CAEKpxBmHhZ+2WNXJEPbQFS6KeKsqRrZeNodRnu1M5yLc15DerA@mail.gmail.com>
 <CA+E=qVd+uM0Aq_=sf+fomQ-m+3Oy0MdG7OPjF5tVagG1UgKYzg@mail.gmail.com>
 <20171205080149.2siofhpynfrvnoiq@flea.lan>
Message-ID: <CA+E=qVeZtWqLZddHtZMv264bWaVcReToYqkriYryf+wZnUVtCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 12:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, Dec 03, 2017 at 11:34:06PM -0800, Vasily Khoruzhick wrote:
>> I'd keep it sun50i_a64_acodec_i2s, since other 3 I2S modules aren't
>> compatible with this one, but similar to H3.
>
> Please don't top-post.
>
> What are those differences?

Different registers and their locations. Compare quirks for
sun50i_a64_acodec_i2s and sun8i_h3_i2s fro details.

> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
