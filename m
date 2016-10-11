From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 11 Oct 2016 15:38:06 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Intel e1000e driver
In-Reply-To: <8265935.TobkRj9BnG@wuerfel>
References: <1475959264-16582-1-git-send-email-scott.branden@broadcom.com>
 <8265935.TobkRj9BnG@wuerfel>
Message-ID: <464e62ad-476e-5a2b-cdb4-c4e7f7f34e7d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 16-10-10 12:47 AM, Arnd Bergmann wrote:
> On Saturday, October 8, 2016 1:41:04 PM CEST Scott Branden wrote:
>> Enable support for the Intel e1000e driver
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>
> Can we make this a loadable module and group it with the other
> ethernet drivers?
>
We use a fixed rootfs image to test the kernel.  For simplicity we don't 
construct a rootfs or load any modules.  We just test the kernel image. 
So for us every defconfig we use needs to be set to y to use the 
upstreamed kernel.

Plus, how do you NFS mount a rootfs if the ethernet driver is a loadable 
module?
> 	Arnd
>

Regards,
  Scott
