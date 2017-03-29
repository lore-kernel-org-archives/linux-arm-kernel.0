From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 29 Mar 2017 15:26:05 +0800
Subject: [PATCH 2/2] ARM: dts: sun5i: Add interrupt for display backend
In-Reply-To: <20170329071303.ft7oukmhczihy2xb@lukather>
References: <20170327143847.16259-1-wens@csie.org>
 <20170327143847.16259-3-wens@csie.org>
 <20170329071303.ft7oukmhczihy2xb@lukather>
Message-ID: <CAGb2v66BsX=6906ubPcLD=ayGp4EmrbHyPmjDOVbZw9a_ZO_Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 3:13 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Mar 27, 2017 at 10:38:47PM +0800, Chen-Yu Tsai wrote:
>> The display backend on sun5i shares the same interrupt line as the
>> display frontend. Add it.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> And ideally, patches prefix shouldn't have dts here too. I've dropped
> it and applied, thanks!

Seems like this was a recent policy change? Or almost everyone was getting
it wrong in the past.

>> This won't directly apply to old releases. We may want to backport
>> them though?
>
> Yep, probably. Do you want to send it to stable?

It won't apply, due to the recent sun5i merger. We could wait until
it lands in Linus' tree, then send a backport patch to stable, to
keep the noise to a minimum.

ChenYu
