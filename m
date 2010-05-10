From: adrian.wenl@gmail.com (Lei Wen)
Date: Mon, 10 May 2010 19:15:58 +0800
Subject: adding pxa3xx_nand_flash to platform data
In-Reply-To: <1273466610.6926.5.camel@pe-dt434>
References: <1273046285.29563.311.camel@pe-dt434>
	<x2mf17812d71005050156h8e23b9cfxb651d176ab8bfa89@mail.gmail.com>
	<o2gf17812d71005050156y681feb36la0b26679bb074d7c@mail.gmail.com>
	<p2u771cded01005060220vd3e9e3d6i4ecd581ef3ef12d4@mail.gmail.com>
	<1273466610.6926.5.camel@pe-dt434>
Message-ID: <AANLkTinvEYwK7fH49LgjeyXLznCrTRtKTFs40HbIluuC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Siddarth,

This patch set is base on Eric's pxa-linux-2.6.git devel branch.
http://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git

You could try it on that git. If anything wrong, please let me know.

Thanks,
Lei

On Mon, May 10, 2010 at 12:43 PM, Siddarth Gore <gores@marvell.com> wrote:
> On Thu, 2010-05-06 at 02:20 -0700, Haojian Zhuang wrote:
>> On Wed, May 5, 2010 at 4:56 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> > On Wed, May 5, 2010 at 4:56 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> >> On Wed, May 5, 2010 at 3:58 PM, Siddarth Gore <gores@marvell.com> wrote:
>> >>> Hello Eric,
>> >>>
>> >>> Currently I need to enable the deprecated MTD_NAND_PXA3xx_BUILTIN
>> >>> support for Aspenite DB board (pxa168). I have a patch ready to add
>> >>> pxa3xx_nand_flash in aspenite.c but I was wondering about the cmdset
>> >>> field in it.
>> >>> Looks like it is the same for all boards (depending upon the page size).
>> >>> So should I add it to the board specific setup file or remove it from
>> >>> pxa3xx_nand_platform_data (and put it in say, pxa3xx_nand_info)?
>> >>>
>> >>> If there are boards which require a different cmdset then we have to go
>> >>> with first option, if not, we can use option two and save some code
>> >>> duplication.
>> >>>
>> >>
>> >> There are normally two sets of commands, yet the code derived from some
>> >> previous work that there were several subtle different command sets.
>> >>
>>
>> We already formated the patches of removing the duplication. Now it's
>> put into mailist. Try these patches.
>>
> Thanks a lot Haojian. I have tried the whole patchset and it is working
> fine on my Aspenite DB board. Did not get a chance to check individual
> patches though.
>
> Also, some patches did not get applied with git-am. I had to manually
> apply them.
>
> -siddarth
>
>> Thanks
>> Haojian
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
