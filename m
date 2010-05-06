From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 6 May 2010 05:20:28 -0400
Subject: adding pxa3xx_nand_flash to platform data
In-Reply-To: <o2gf17812d71005050156y681feb36la0b26679bb074d7c@mail.gmail.com>
References: <1273046285.29563.311.camel@pe-dt434>
	<x2mf17812d71005050156h8e23b9cfxb651d176ab8bfa89@mail.gmail.com>
	<o2gf17812d71005050156y681feb36la0b26679bb074d7c@mail.gmail.com>
Message-ID: <p2u771cded01005060220vd3e9e3d6i4ecd581ef3ef12d4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 5, 2010 at 4:56 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, May 5, 2010 at 4:56 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Wed, May 5, 2010 at 3:58 PM, Siddarth Gore <gores@marvell.com> wrote:
>>> Hello Eric,
>>>
>>> Currently I need to enable the deprecated MTD_NAND_PXA3xx_BUILTIN
>>> support for Aspenite DB board (pxa168). I have a patch ready to add
>>> pxa3xx_nand_flash in aspenite.c but I was wondering about the cmdset
>>> field in it.
>>> Looks like it is the same for all boards (depending upon the page size).
>>> So should I add it to the board specific setup file or remove it from
>>> pxa3xx_nand_platform_data (and put it in say, pxa3xx_nand_info)?
>>>
>>> If there are boards which require a different cmdset then we have to go
>>> with first option, if not, we can use option two and save some code
>>> duplication.
>>>
>>
>> There are normally two sets of commands, yet the code derived from some
>> previous work that there were several subtle different command sets.
>>

We already formated the patches of removing the duplication. Now it's
put into mailist. Try these patches.

Thanks
Haojian
