From: robh@kernel.org (Rob Herring)
Date: Fri, 10 Nov 2017 15:10:24 -0600
Subject: [PATCH V3 09/11] clk: sprd: add clocks support for SC9860
In-Reply-To: <CAAfSe-tadvpgJ0OC00Ccc+y+84t90dArfAu9ASOG77Hnw9Z=RA@mail.gmail.com>
References: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
 <20171102065626.21835-10-chunyan.zhang@spreadtrum.com>
 <20171106214335.qvuvcwahemnpwftt@rob-hp-laptop>
 <CAAfSe-tadvpgJ0OC00Ccc+y+84t90dArfAu9ASOG77Hnw9Z=RA@mail.gmail.com>
Message-ID: <CAL_Jsq+3wuzCPh1Pkbq79t9zkef-Gvg9AW4pgrKvwOuRJJyn1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 9, 2017 at 2:18 AM, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> Hi Rob and Stephen,
>
> On 7 November 2017 at 05:43, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Nov 02, 2017 at 02:56:24PM +0800, Chunyan Zhang wrote:
>>> This patch added the list of clocks for Spreadtrum's SC9860 SoC,
>>> together with clock initialization code.
>>>
>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>>> ---
>>>  drivers/clk/sprd/Kconfig                    |   10 +
>>>  drivers/clk/sprd/Makefile                   |    3 +
>>>  drivers/clk/sprd/sc9860-clk.c               | 1987 +++++++++++++++++++++++++++
>>>  include/dt-bindings/clock/sprd,sc9860-clk.h |  408 ++++++
>>
>> This belongs in the binding doc patch.
>
> I noticed that this kind of files were submitted in driver patch
> before when adding a new driver, how about I just put it into a single
> patch in the next version?

It's been done all ways, but the correct way is as I told you. Binding
doc and header in one, driver in another patch.

Rob
