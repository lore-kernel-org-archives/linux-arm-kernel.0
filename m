From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Jul 2017 10:19:04 -0300
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
Message-ID: <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Noel,

On Thu, Jul 20, 2017 at 10:13 AM, Vellemans, Noel
<Noel.Vellemans@visionbms.com> wrote:
> Hi,
>
>
>>>Please try a more recent kernel first. 4.4 is quite ancient, and MX53 is well supported on 4.12 or 4.13+.
>>>Regards,
>>>Robert
>
> I' already did ( maybe I was not clear enough in the previous mail , did test  4.4.x series and 4.12  kernel ! )
>
> 4.12 Has the exactly same problem  ( ONFI parameter page can not be read , on ONE of the boards)

Looks like your mixing the performance thread with the mxc_nand one
:-) These are completely different topics.
