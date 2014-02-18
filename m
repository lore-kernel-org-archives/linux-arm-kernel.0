From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 18 Feb 2014 11:35:45 -0300
Subject: [PATCH v4 0/8] ARM: sunxi: rename DT clock node names to clk@N
In-Reply-To: <20140207192444.GM3192@lukather>
References: <1391392304-4660-1-git-send-email-wens@csie.org>
 <20140207192444.GM3192@lukather>
Message-ID: <53036FC1.8050809@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 07/02/14 16:24, Maxime Ripard escribi?:
> On Mon, Feb 03, 2014 at 09:51:36AM +0800, Chen-Yu Tsai wrote:
>> Hi everyone,
>>
>> This is v4 of the clock node renaming patch series, which renames
>> the clock nodes in sunxi dts to conform to device tree naming
>> conventions, i.e. clk at N. Dummy clocks that will be renamed/removed
>> later, or clocks sharing registers are not renamed.
>>
>> Renamed clock nodes have clock-output-names properties added to
>> desginate their names. Support for this is added in the first
>> patch.
>
> Applied the last 4 patches to sunxi/dt-for-3.15.

And I've applied the first 4 to sunxi-clk-for-mike some time ago.

Thanks for working on this!

Emilio
