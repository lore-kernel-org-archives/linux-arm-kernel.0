From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri, 06 May 2016 23:22:24 +0200
Subject: [PATCH 1/2] ARM: dts: igep00x0: Add SD card-detect.
In-Reply-To: <CABxcv=nZ1hjVGnNG65eKDrxAYFBcavML+GjxXtfTcVO5N83xkA@mail.gmail.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
 <CABxcv=nZ1hjVGnNG65eKDrxAYFBcavML+GjxXtfTcVO5N83xkA@mail.gmail.com>
Message-ID: <572D0B10.60908@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 06/05/16 23:07, Javier Martinez Canillas wrote:
> Hello Enric,
> 
> On Fri, May 6, 2016 at 5:02 PM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> Fix SD card remove/insert detection by adding the correct card-detect
>> pin. All IGEP OMAP3 based boards use the same card-detect pin.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> Shouldn't his be Suggested-by: Ladislav Michl <ladis@linux-mips.org> instead?
> 
> Or if the patch was originally from Ladis, then he should remain the
> author with your S-o-B after his.
> 

Well Ladis sent the same patch as I had in my local repository for long
time, so to be strict the correct is have two authors and two S-o-B. My bad
is not send the patch before.

> Patch looks good to me though.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
> Javier
> 
