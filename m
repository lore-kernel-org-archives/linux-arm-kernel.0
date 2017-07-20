From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Thu, 20 Jul 2017 13:57:17 +0000
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
 <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A70759249B@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert... 

I was mixing up 2 topic's .. ( my mistake sorry ) .


In short... I did a QUICK test on the 4.12 kernel as well ( but need to add lots of custom drivers ) in order to get it running on the same roofs.

But,  I believe FABIO ESTEVAM ( who was trying to give me some first aid 'help' ) did some test on a 4.12 kernel ( for the performance issue) .. and it seems it is in the ALLMOST SAME SPEED range as the 4.4.x kernel ( there was  small improvement ) but it was certainly not at the same speed as the 2.6.35 kernel .

( for the test program that looped for the Kernel time)

Regards Noel

NOTE: I'll try to get 4.12 ( or 4.13 ) running ( but needs a lot of patches.. that require manual rework if I want to run then om our hardware)




_______________________
Noel Vellemans
BMS bvba

-----Original Message-----
From: Fabio Estevam [mailto:festevam at gmail.com] 
Sent: Thursday, July 20, 2017 3:19 PM
To: Vellemans, Noel
Cc: Robert Schwebel; linux-arm-kernel at lists.infradead.org
Subject: Re: IMX53 on recent 4.4.x kernels

Hi Noel,

On Thu, Jul 20, 2017 at 10:13 AM, Vellemans, Noel <Noel.Vellemans@visionbms.com> wrote:
> Hi,
>
>
>>>Please try a more recent kernel first. 4.4 is quite ancient, and MX53 is well supported on 4.12 or 4.13+.
>>>Regards,
>>>Robert
>
> I' already did ( maybe I was not clear enough in the previous mail , 
> did test  4.4.x series and 4.12  kernel ! )
>
> 4.12 Has the exactly same problem  ( ONFI parameter page can not be 
> read , on ONE of the boards)

Looks like your mixing the performance thread with the mxc_nand one
:-) These are completely different topics.
