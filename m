From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Jan 2014 09:44:21 +0800
Subject: [linux-sunxi] Re: [PATCH v2 1/8] clk: sunxi: add
 clock-output-names dt property support
In-Reply-To: <20140107221430.GE3103@lukather>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
 <1388987892-23733-2-git-send-email-wens@csie.org>
 <20140107221430.GE3103@lukather>
Message-ID: <CAGb2v64ZE1an+dGNZey=nER_ZUEK4Og6FYXKUtowtiRQ_q=azA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 8, 2014 at 6:14 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Mon, Jan 06, 2014 at 01:58:05PM +0800, Chen-Yu Tsai wrote:
>> sunxi clock drivers use dt node name as clock name, but clock
>> nodes should be named clk at X, so the names would be the same.
>> Let the drivers read clock names from dt clock-output-names
>> property.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Please document this in Documentation/devicetree/bindings.
>

Do you want them in the same patch, or separate?

I think someone asked about this yesterday, but don't remember
the conclusion.


Thanks
ChenYu
