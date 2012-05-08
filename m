From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 9 May 2012 06:12:15 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <4FA9794A.7030607@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
 <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com>
 <87ehs4pfw4.fsf@ti.com>
 <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
 <20120404111524.GF32505@mudshark.cambridge.arm.com>
 <20120426180719.GC20186@mudshark.cambridge.arm.com>
 <4FA45580.8070802@ti.com> <87ipg76hfm.fsf@ti.com>
 <4FA8284C.7080803@ti.com> <87k40nzi3i.fsf@ti.com>
 <4FA8FCFF.40105@ti.com>
 <CAORVsuWMhVQkQAmsyrprvW-0hK4y=RgGayn0p8WhyksScauBQQ@mail.gmail.com>
 <4FA9138D.8010604@ti.com>
 <CAORVsuWQ6o64Jhpox0ZvjYAfzDJkXCc6XYX2a6o_cOdNyFdA0g@mail.gmail.com>
 <87aa1isrg2.fsf@ti.com> <4FA927B1.4020108@ti.com>
 <87wr4mr6io.fsf@ti.com> <4FA9794A.7030607@ti.com>
Message-ID: <CACVXFVOVFPnvWxtqYPPz2drY3AjPWxJHqF5ZCiEdmEqOrdr4Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 3:51 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
>
> I had to make a couple mods to Ming's patches but I do have something
> working now that _should_ not break PM. However, per my previous email
> (in response to Benoit's) I am struggling with the definition of the
> CLKDM_CAN_XXXXXX_AUTO flags to know the correct way to fix this.
>
> I was going to send out my patches, but I wanted to get some more
> feedback on this first.

I can test your patch once I return home from business trip next week.


Thanks,
--
Ming Lei
