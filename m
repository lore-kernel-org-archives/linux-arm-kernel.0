From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Feb 2012 16:54:00 +0100
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <20120221153706.GD9371@game.jcrosoft.org>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <20120221153706.GD9371@game.jcrosoft.org>
Message-ID: <4F43BE18.9080104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2012 04:37 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 17:04 Tue 21 Feb     , Haojian Zhuang wrote:
>> Remove the hardcode definition of rtc registers, use ioremap() instead.
>> Append clk support for arch-mmp, so add dummy clk in arch-sa1100/arch-pxa.
> looks gine 

gine, or fone, maybe?...

> Best Regards,
> J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
