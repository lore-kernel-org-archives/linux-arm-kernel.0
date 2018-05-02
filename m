From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2018 15:03:04 +0200
Subject: [PATCH 4/6] pinctrl: fsl: add scu based pinctrl support
In-Reply-To: <20180502123638.qgolj3h6ycbx6aas@pengutronix.de>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
 <1524855713-15527-5-git-send-email-aisheng.dong@nxp.com>
 <CACRpkdY5zSNYvXD3icbO+4R7Mc7TDhHCoUU0gikE6A+=ZFA=Kg@mail.gmail.com>
 <CACRpkdbiPQ8h_0cD5nkG21wQSq5FrcdNXK1AvE-AP7kWy3yUqw@mail.gmail.com>
 <20180502123638.qgolj3h6ycbx6aas@pengutronix.de>
Message-ID: <CACRpkdbgi6f2famHA_QUb0zZY7rF3QqbDzcfS_X=czcRJGMMyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 2:36 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Linus,
>
> On Wed, May 02, 2018 at 02:29:04PM +0200, Linus Walleij wrote:
>> On Wed, May 2, 2018 at 2:27 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Fri, Apr 27, 2018 at 9:01 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
>> >
>> >> Some i.MX SoCs (e.g. MX8QXP and MX8QM) contain a system controller
>> >> that is responsible for controlling the pad setting of the IPs that
>> >> are present. Communication between the host processor running an OS
>> >> and the system controller happens through a SCU protocol.
>> >> This patch adds SCU protocol based pinctrl drivers.
>> >>
>> >> Cc: Linus Walleij <linus.walleij@linaro.org>
>> >> Cc: Shawn Guo <shawnguo@kernel.org>
>> >> Cc: Fabio Estevam <festevam@gmail.com>
>> >> Cc: Stefan Agner <stefan@agner.ch>
>> >> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
>> >> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> >
>> > Patch applied.
>>
>> Bah on second thought holding this back since I see thyere are
>> some discussions about the bindings in the next patch.
>
> Also note that this patch depends on the SCU base support posted elsewhere
> as Dong mentioned in his introductory mail.

Aha is that a compile-time dependence?

I guess it would be better if it is one big series if it is supposed
to be merged in one big series.

Yours,
Linus Walleij
