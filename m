From: padma.kvr@gmail.com (Padma Venkat)
Date: Tue, 23 Jul 2013 09:38:00 +0530
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <20130712084932.GY24508@sirena.org.uk>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <29860116.IF545KsGYb@thinkpad>
 <20130711112023.GM24508@sirena.org.uk>
 <2214161.FSfscAvpna@thinkpad>
 <20130711130139.GQ24508@sirena.org.uk>
 <CAAgF-BdM4jw0o4+ELVo_N029tbgMJBBqJxU91e=TgBNiiREyaA@mail.gmail.com>
 <20130712084932.GY24508@sirena.org.uk>
Message-ID: <CAAgF-BfdfuhoFDH+SeZogXh1wju34hGp-T9N7_+mnapHfc2yww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Jul 12, 2013 at 2:19 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 12, 2013 at 10:07:22AM +0530, Padma Venkat wrote:
>
>> A new version number is added when a there was some change in the IP
>> like adding a internal mux to the IP, adding multi channel support,
>> adding reset control bit. This was done in the older code with
>> platform device.
>> Same thing is followed here. So as previously done, adding a new
>> compatible name like "samsung,i2s-v6" with new quirk
>> "samsung,supports-tdm" is okey?
>
> Yes, this is good but the quirk should just be found by software based
> on the compatible string rather than in the DT.

You mean I just need to initialize the quirks in the driver based on
the compatible string?
So what about the quirks that I added previously on 5250? Should I
also follow the same thing for other quirks?

Or it need to be passed via driver data as it is done in spi driver?
Please clarify me.

Thanks
Padma
