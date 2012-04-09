From: cjb@laptop.org (Chris Ball)
Date: Sun, 08 Apr 2012 21:26:19 -0400
Subject: [PATCH v7 09/11] ARM: pxa: change gpio to platform device
In-Reply-To: <CAN1soZxOX9LE2+93kKvnmLx2JpmCDWX0pDA8Cf9r4=oncdB+Yw@mail.gmail.com>
 (Haojian Zhuang's message of "Fri, 6 Apr 2012 13:55:34 +0800")
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
 <1320806851-13928-10-git-send-email-haojian.zhuang@marvell.com>
 <87pqbl5wvt.fsf@laptop.org> <874nsx4g8d.fsf@laptop.org>
 <CAN1soZxOX9LE2+93kKvnmLx2JpmCDWX0pDA8Cf9r4=oncdB+Yw@mail.gmail.com>
Message-ID: <878vi51yro.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 06 2012, Haojian Zhuang wrote:
>> Ah, I eventually found your "ARM: mmp: append irq name of gpio device"
>> patch, which was merged in 3.4-rc1 and fixes gpio-pxa on mach-mmp.
>> I think this patch should go to stable@, since the regression is
>> still unfixed in 3.2 and 3.3.
>>
> Who or which mailing list should I cc for this fix on 3.2 and 3.3?

For how to get patches included in stable releases, see
Documentation/stable_kernel_rules.txt:

  Procedure for submitting patches to the -stable tree:

   - Send the patch, after verifying that it follows the above rules, to
     stable at vger.kernel.org.  You must note the upstream commit ID in the
     changelog of your submission, as well as the kernel version you wish
     it to be applied to.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
