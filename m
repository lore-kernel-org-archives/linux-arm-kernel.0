From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Dec 2017 17:25:22 +0800
Subject: [PATCH v4 10/10] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <20171201155808.rxgp7pz7nmr6tab7@flea.lan>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <afc22693e34c11231fc85a0dc6af3ffb340ba9b2.1512135804.git-series.quentin.schulz@free-electrons.com>
 <20171201155808.rxgp7pz7nmr6tab7@flea.lan>
Message-ID: <CAGb2v64pjQMEzDtTVjuoiVZAWS9X5VWzZN2gTM0r_kb0AJSTNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 11:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Dec 01, 2017 at 02:44:51PM +0100, Quentin Schulz wrote:
>> On AXP813/818, GPIO0 and GPIO1 can be used as LDO as (respectively)
>> ldo_io0 and ldo_io1.
>>
>> Let's add the pinctrl properties to the said regulators.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
