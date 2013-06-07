From: jbe@pengutronix.de (Juergen Beisert)
Date: Fri, 07 Jun 2013 09:34:01 +0200
Subject: mxsfb: DATA_FORMAT_24_BIT flag outputs invalid colours
In-Reply-To: <51B18BA0.50506@digi.com>
References: <519E03B0.1080006@digi.com> <519F4435.5010703@digi.com>
 <201305241300.25461.jbe@pengutronix.de>
 <201305241533.19941.jbe@pengutronix.de> <20130607072103.GF14209@lukather>
 <51B18BA0.50506@digi.com>
Message-ID: <51B18CE9.8080704@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hector,

On 07.06.2013 09:28, Hector Palacios wrote:
> On 06/07/2013 09:21 AM, maxime.ripard at free-electrons.com wrote:
>> Hi Hector,
>>
>> On Fri, May 24, 2013 at 03:33:19PM +0200, Juergen Beisert wrote:
>>> Someone told me, Qt5 cannot handle this special RGB666 mode (even not the
>>> def_rgb666_shift memory layout mentioned above). My test are based on Qt4.
>>> Qt5 needs a regular RGB888 mode, which should silently be converted
>>> internally to RGB666 in the hardware.
>>>
>>> So, your patch to always use the RGB888 memory layout seems to be the right
>>> way to go.
>>
>> Do you plan on submitting this patch? (Or did you already submit it and
>> I overlooked it?)
> 
> I wasn't sure that everybody involved agreed with the patch.
> @Juergen, would the patch break your platform?

No, we need to switch to this data format here, too.

> Additionally, the guys from Crystalfontz didn't comment on it, but their platform is 
> also using a 18bit data bus width and 32bpp.
> 
> If no-one is against I'll be glad to submit it.

You can have my Acked-by: Juergen Beisert <jbe@pengutronix.de> for this patch.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
