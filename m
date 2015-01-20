From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Jan 2015 09:50:37 +0800
Subject: [PATCH v4 3/9] ARM: dts: sun9i: Add clock-indices property for
 bus gate clocks
In-Reply-To: <20150119215912.GM4367@lukather>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
 <1421471974-32719-4-git-send-email-wens@csie.org>
 <20150119215912.GM4367@lukather>
Message-ID: <CAGb2v67TDGrgbf1SA6oR8x1j3OMHywfki6QxfvJ4tb8_AHdmCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 5:59 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jan 17, 2015 at 01:19:28PM +0800, Chen-Yu Tsai wrote:
>> of_clk_get_parent_name() uses the clock-indices property to resolve
>> clock phandle arguments in case that the argument index does not
>> match the clock-output-names sequence.
>>
>> This is the case on sunxi, where we use the actual bit index as the
>> argument to the phandle. Add the clock-indices property so that
>> of_clk_get_parent_name() resolves the names correctly.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Did you change anything in that patch?
>
> I already applied it from v3, so let me know if I need to drop it.

Please drop it. I just didn't realize you merged it after our
discussion.

ChenYu
