From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 31 Oct 2012 00:20:47 +0300
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <509032F6.1050301@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
 <CACTFLAOwUsWbqK-R1OLNfNTnkp7Mo3hFwu78dFKT8i8goTgdKw@mail.gmail.com>
 <CA+E=qVeup8QzqAiURzEfG8a2vp_rBJ-by8FORLEzSCfkxiyjtQ@mail.gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
 <508E5DFB.3060002@gmail.com>
 <CA+E=qVcRM834_JFZskL7DEJQ10YsYexCeY3CE67fjJk4_WJLUw@mail.gmail.com>
 <508E61E7.7090502@gmail.com>
 <CA+E=qVcJ=WLJwS49zgb_=6or7Me3LLGQtBbfzBtS-p+U6Tw-pQ@mail.gmail.com>
 <508E651A.5070009@gmail.com>
 <CA+E=qVchrOXAL+cPD0-bZKSAjgyjoEFEqajva+SPtJBPOVGE=w@mail.gmail.com>
 <509032F6.1050301@gmail.com>
Message-ID: <CA+E=qVfX6vrGVhmy5+KGZ_H78ERzdFcK+fnTz3z79YcQZuJrDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 11:05 PM, Daniel Mack <zonque@gmail.com> wrote:
>> One more question: what should I use instead of pxa2xx_mfp_config in
>> DT board to configure pin modes?
>
> Haojian was working on the PXA pinctrl drivers, but I don't know how far
> that is yet.
>
> If that's not yet there, have a look at the pinctrl-single driver. It's
> admittedly not as nice to use as the constants in the board file as DT
> lacks defines for numerical constants, but's at least a workaround.
>
> On a more general note, it's arguable whether this kind of setup should
> be done in the bootloader after all.
>
>
> Daniel

OK, thanks for suggestion!

Regards
Vasily
