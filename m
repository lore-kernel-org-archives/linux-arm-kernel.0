From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 2 Jun 2016 10:28:37 +0200
Subject: [PATCH] include/linux/arm-smccc.h: avoid sign extension problem
In-Reply-To: <20160601160401.GZ19428@n2100.arm.linux.org.uk>
References: <1464785361-20038-1-git-send-email-jens.wiklander@linaro.org>
 <20160601160401.GZ19428@n2100.arm.linux.org.uk>
Message-ID: <CAHUa44Gv4+aFuBNdsAy3U1iNAR+evM1bfrJgx39GQgERBQ-gWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 6:04 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jun 01, 2016 at 02:49:21PM +0200, Jens Wiklander wrote:
>> Prior to this patch the ARM_SMCCC_FAST_CALL constant was of a signed
>> type causing unwanted sign extension. This patch explicitly selects an
>> unsigned type for the constant.
>>
>> Reported-by: Saksham Jain <sakjain92@gmail.com>
>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> Looks fine to me.  Who's merging this change?  If they're going some
> other route:
>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks, Russel. I was hoping you would take it when it's reviewed.

Thanks,
Jens
