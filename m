From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Jan 2017 10:02:31 -0800
Subject: [PATCH] ARM: defconfig: include QCOM_EBI2 in multi_v7
In-Reply-To: <20170110100931.15791-1-linus.walleij@linaro.org>
References: <20170110100931.15791-1-linus.walleij@linaro.org>
Message-ID: <CAOesGMh-5oyzjsby=R9c=euAngsq9=cNwJFDhEEKWtzxoqzLKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 2:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds the Qualcomm External Bus Interface 2 to the multi_v7
> defconfig: it is hard for users to realize that this is a
> required driver for getting things like ethernet, and a necessary
> prerequisite to get the external bus discoverable on the
> MSM8660/APQ8060 machines.

Is it the kind of option that should really be selected through
Kconfig instead for those platforms?

I.e. is it ever really likely that we'll want it off?


-Olof
