From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 29 Jan 2010 12:27:21 -0500
Subject: [patch v2 2/2] at91_udc.c use spinlocks instead of local_irq_xxx
In-Reply-To: <20100129162155.824407360@gmail.com>>
References: <20100129162029.998540038@gmail.com>>
	<20100129162155.824407360@gmail.com>>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020E96FA@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 29, 2010 9:21 AM, Harro Haan wrote:
>
> The locking code of this driver is reworked for preempt-rt.
>
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> ---
>  drivers/usb/gadget/at91_udc.c |  139 ++++++++++++++++++++++++++++--------------
>  drivers/usb/gadget/at91_udc.h |    1 
>  2 files changed, 94 insertions(+), 46 deletions(-)

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
