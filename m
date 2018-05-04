From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 4 May 2018 10:07:12 +0800
Subject: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
In-Reply-To: <20180503231604.GD13402@sirena.org.uk>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-4-yixun.lan@amlogic.com>
 <20180503231604.GD13402@sirena.org.uk>
Message-ID: <e5610b7f-9e34-3925-cb40-1c62a3c470d2@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

On 05/04/18 07:16, Mark Brown wrote:
> On Thu, May 03, 2018 at 09:36:44PM +0000, Yixun Lan wrote:
>> From: Sunny Luo <sunny.luo@amlogic.com>
>>
>> The SPICC controller in Meson-AXG SoC is capable of using
>> a linear clock divider to reach a much fine tuned range of clocks,
>> while the old controller only use a power of two clock divider,
>> result at a more coarse clock range.
>>
>> Also convert the clock registeration into Common Clock Framework.
> 
> This would be better split into two patches - one adding the new linear
> clock divider and the other one doing the CCF conversion.  Splitting
> things out like that makes them much easier to review as each change is
> only doing one thing.
> 

it's maybe obscure in my previous commit message, the clock divider
support is actually achieved via CCF framework, it can be split as two
independent patches..

I'm CCing clock mailing list (will do if I need to send a v2)

Yixun
