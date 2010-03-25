From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 25 Mar 2010 12:20:38 -0500
Subject: [spi-devel-general] [PATCH v2 2/3] ep93xx: added chip revision
	reading function
In-Reply-To: <20100325090638.GA20512@gw.healthdatacare.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B02708426976368AC725D@AUSP01VMBX24.collaborationhost.net>
	<20100325090638.GA20512@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B02708426976368F66FD1@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 25, 2010 2:07 AM, Mika Westerberg wrote:
> On Thu, Mar 18, 2010 at 12:27:15PM -0500, H Hartley Sweeten wrote:
>> On Thursday, March 18, 2010 10:00 AM, Mika Westerberg wrote:
>>> Added a new function: ep93xx_chip_revision() which reads chip revision from the
>>> sysconfig register.
>>> 
>>> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
>> 
>> Hello Mika,
>> 
>> I'm ok with this part of your patch series.
>> 
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> Hello,
>
> Any comments on the v2 series of the driver? If it is OK could it be considered for .35?

Hello Mika,

This part (2/3) I am fine with.

If you want, you can add this as a separated patch to Russell's patch tracker
with my Acked-by above.


For parts 1 and 3.

I tried testing them in my setup with the mmc_spi.c and sst25l.c drivers.  Both
did not work.  For some reason the data read is always either 0x00 or 0xff.

I will try to get some time this week/weekend to look into this.

Regards,
Hartley
