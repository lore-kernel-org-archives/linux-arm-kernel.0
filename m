From: eric@anholt.net (Eric Anholt)
Date: Mon, 07 Aug 2017 10:08:41 -0700
Subject: [PATCH 3/3] irqchip: bcm2836: Move SMP startup code to arch/arm
In-Reply-To: <0f587b52-d9db-3bbe-968d-66b40fba508c@arm.com>
References: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
 <1502058731-12462-4-git-send-email-stefan.wahren@i2se.com>
 <0f587b52-d9db-3bbe-968d-66b40fba508c@arm.com>
Message-ID: <87valzb90m.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> On 06/08/17 23:32, Stefan Wahren wrote:
>> In order to easily provide SMP for BCM2837 on 32-bit and 64-bit
>> the SMP startup code was placed in irq-bcm2836. That's not the
>> right approach. So move this code where it belongs.
>> 
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Fixes: 41f4988cc287 ("irqchip/bcm2836: Add SMP support for the 2836")
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>
> How do you want to get this merged? I can either take it via the irqchip
> tree, or you take it via arm-soc. Just let me know.

The series is:

Tested-by: Eric Anholt <eric@anholt.net>

We'll need to get the DT binding ack, then I'm fine with it going
through arm-soc.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/f8f13976/attachment-0001.sig>
