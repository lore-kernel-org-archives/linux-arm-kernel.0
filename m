From: olof@lixom.net (Olof Johansson)
Date: Sat, 23 Jun 2018 10:14:43 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v4.17 (#2)
In-Reply-To: <87k1ra66o3.fsf@bootlin.com>
References: <871sdvyfxj.fsf@bootlin.com>
 <20180602082431.lahocepns6vub6uq@localhost>
 <87k1ra66o3.fsf@bootlin.com>
Message-ID: <CAOesGMgZS3rsQ0Vww6zgujxj3F5ohy5XgeuN5iWHmioVW0xzgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2018 at 6:57 AM, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
> Hi Olof,
>
>  On sam., juin 02 2018, Olof Johansson <olof@lixom.net> wrote:
>
>> On Mon, May 28, 2018 at 05:10:16PM +0200, Gregory CLEMENT wrote:
>>> Hi,
>>>
>>> Here is the second pull request for fixes for mvebu for v4.17.
>>> Nothing really critical but it needs to be fixed.
>>>
>>> Gregory
>>>
>>> The following changes since commit f43194c1447c9536efb0859c2f3f46f6bf2b9154:
>>>
>>>   ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node (2018-04-27 17:47:24 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.17-2
>>>
>>> for you to fetch changes up to ac62cc9d9cd6fa4c79e171c13dc8d58c3862b678:
>>>
>>>   arm: dts: armada: Fix "#cooling-cells" property's name (2018-05-28 16:54:44 +0200)
>>>
>>> ----------------------------------------------------------------
>>> mvebu fixes for 4.17 (part 2)
>>>
>>>  - Use correct size for ICU nodes (irq controller) on Armada 7K/8K
>>>  - Fix "#cooling-cells" property's name on Synology DS116 (Armada 385)
>>>
>>> ----------------------------------------------------------------
>>> Miquel Raynal (1):
>>>       arm64: dts: marvell: fix CP110 ICU node size
>>>
>>> Viresh Kumar (1):
>>>       arm: dts: armada: Fix "#cooling-cells" property's name
>>
>> Subject here should be 'ARM: dts: ...'
>>
>> The latter is definitely not 4.17 material by now. It's unclear on the ICU
>> patch whether it's causing a real problem in reality, i.e. if it's an urgent
>> regression fix or if it's just fixing up the register range to be correct per
>> documentation.  Let me know if it's a real issue and I can either cherry-pick
>> it or send a separate pull request with just that fix.
>
> Even the first patch did not fix a regression. But it is more just than
> just fixing the documentation as the extension of the size of the
> register set is needed to support more feature provided by ICU (it is
> part of series already submitted).
>
> It's not a problem for me that this PR was not merged in 4.17, but could
> you add it for 4.18 in the current merge window?

Merged into fixes now, apologies for the delay.


-Olof
