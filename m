From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2012 19:41:21 +0100
Subject: [PATCH] pinctrl: delete raw device pointers in pinmux maps
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178E12470D@HQMAIL01.nvidia.com>
References: <1328117053-27807-1-git-send-email-linus.walleij@stericsson.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178E12470D@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdbGwfR37HQ=QUEooyVzJ2zoD0bjaZ_-TSaFGiBZG_dTCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2012 at 6:37 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Linus Walleij wrote at Wednesday, February 01, 2012 10:24 AM:
>> After discussion with Mark Brown in an unrelated thread about
>> ADC lookups, it came to my knowledge that the ability to pass
>> a struct device * in the regulator consumers is just a
>> historical artifact, and not really recommended. Since there
>> are no in-kernel users of these pointers, we just kill them
>> right now, before someone starts to use them.
>>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I didn't review the code, but just wanted to note that
> Documentation/pinctrl.txt needs some updates too, e.g. "Pinmux
> board/machine configuration" says:

Good catch! Spinning a v2 with that removed.

Thanks,
Linus Walleij
