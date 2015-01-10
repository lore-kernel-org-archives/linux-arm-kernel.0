From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 10 Jan 2015 22:44:00 +0100
Subject: [PATCH 4/5] pinctrl: mvebu: a38x: Add UART1 muxing options
In-Reply-To: <20150109114505.GR24989@titan.lakedaemon.net>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417790698-9792-5-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdbhykx1FaxKrQ25yO=12K4Q03LxoX4n_Ba1Fkxmbdv-iQ@mail.gmail.com>
 <20150109114505.GR24989@titan.lakedaemon.net>
Message-ID: <CACRpkdb1Rjp8sN-eNjcZ9jch_GPNK13Zf5U0Qrg=j3aNeZT6Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 12:45 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Jan 09, 2015 at 11:05:53AM +0100, Linus Walleij wrote:
>> On Fri, Dec 5, 2014 at 3:44 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>
>> > The MPP19 and MMP20 pins also have the ability to be muxed to the uart1
>> > function.
>> >
>> > Add this case to the pinctrl driver.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Patch applied with Jason's ACK.
>
> I did?

Yeah...

Date: Fri, 5 Dec 2014 10:26:26 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>,
Andrew Lunn <andrew@lunn.ch>,
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
Linus Walleij <linus.walleij@linaro.org>,
Thomas Petazzoni <thomas@free-electrons.com>,
linux-arm-kernel at lists.infradead.org,
Tawfik Bayouk <tawfik@marvell.com>,
Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCH 4/5] pinctrl: mvebu: a38x: Add UART1 muxing options
Message-ID: <20141205152626.GF22670@titan.lakedaemon.net>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417790698-9792-5-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1417790698-9792-5-git-send-email-maxime.ripard@free-electrons.com>
User-Agent: Mutt/1.5.20 (2009-06-14)

On Fri, Dec 05, 2014 at 03:44:57PM +0100, Maxime Ripard wrote:
> The MPP19 and MMP20 pins also have the ability to be muxed to the uart1
> function.
>
> Add this case to the pinctrl driver.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.


Yours,
Linus Walleij
