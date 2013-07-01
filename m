From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 01 Jul 2013 19:29:50 +0200
Subject: [PATCH] DMA: Fix Marvell Orion and mv_xor after MEMSET removal
In-Reply-To: <6583540.4QCOENPlIG@amdc1032>
References: <1372690589-2218-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51D19CD1.3030900@gmail.com> <20130701151720.GC19937@titan.lakedaemon.net>
 <6583540.4QCOENPlIG@amdc1032>
Message-ID: <51D1BC8E.6000204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/13 19:24, Bartlomiej Zolnierkiewicz wrote:
> On Monday, July 01, 2013 11:17:20 AM Jason Cooper wrote:
>> On Mon, Jul 01, 2013 at 05:14:25PM +0200, Sebastian Hesselbarth wrote:
>>> On 07/01/13 17:04, Jason Cooper wrote:
>>>> On Mon, Jul 01, 2013 at 04:56:29PM +0200, Sebastian Hesselbarth wrote:
>>> Also, I will sent a follow-up patch to remove memset references from
>>> Marvell SoC dts/dtsi and the binding documentation soon.
>>>
>>> I guess, Bartolomiej should pick them up and resend his patch set, or
>>> leave Marvell alone and you pick them up.
>>
>> If Bartolomiej doesn't take it, please split your changes into two
>> patches, one for plat-orion, and one for drivers.
>
> Andrew has already applied incremental patch fixing build problems to his
> tree (though it is not yet in linux-next):
>
> 	http://www.ozlabs.org/~akpm/mmots/broken-out/drivers-dma-remove-unused-support-for-memset-operations-v3.patch
>
> The rest of changes from Sebastian are contained in another incremental
> patch which I've attached to this mail. They can be also folded into
> the first patch (which is what Andrew will probably do before sending them
> to Linus).

Ok, great! Then I will sent the DT clean-up patches to be taken through
Jason's tree with the other stuff I have for v3.11-rc1.

Sebastian
