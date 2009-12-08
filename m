From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 8 Dec 2009 11:03:25 +0800
Subject: [PATCH V2] ARM: NUC900: add GDMA driver support for nuc900
	platform
In-Reply-To: <713d0d430912071011w76600af1l867d8f52b61d53da@mail.gmail.com>
References: <713d0d430911260242j579d86b3r7eeade0007d2a94c@mail.gmail.com>
	<20091129121614.GA11445@n2100.arm.linux.org.uk>
	<713d0d430912070753o28a8d538qa71b8af8c4415d73@mail.gmail.com>
	<20091207171851.GD26821@n2100.arm.linux.org.uk>
	<713d0d430912071011w76600af1l867d8f52b61d53da@mail.gmail.com>
Message-ID: <e68bb3470912071903u4657b911nc56bf0f667c37e9e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  Hu,

When you make your patch via 'diff -uNr a b xx.patch', Please do pay
attention to the order of a and b.

I think you would want to add the DMA driver rather than delete this,
notice your all  '-'  symbol of this patch.

2009/12/8 Hu Ruihuan <specter118@gmail.com>:
> yes,why?
>
> 2009/12/8 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Mon, Dec 07, 2009 at 11:53:39PM +0800, Hu Ruihuan wrote:
>>> Hi,Russell
>>> ? Thank you for your advice, it's my patch below follow your advice.
>>
>> Did you look at the patch before you sent it?
>>
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
