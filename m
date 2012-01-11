From: yanok@emcraft.com (Ilya Yanok)
Date: Thu, 12 Jan 2012 00:04:14 +0400
Subject: [PATCH 2/2] mt_ventoux: support for TeeJet Mt.Ventoux board
In-Reply-To: <4F02CED6.8090709@compulab.co.il>
References: <1324940912-18164-1-git-send-email-yanok@emcraft.com>
 <1324940912-18164-3-git-send-email-yanok@emcraft.com>
 <4EF97A41.7050605@compulab.co.il> <4EFA4E9C.30307@emcraft.com>
 <4F02CED6.8090709@compulab.co.il>
Message-ID: <4F0DEB3E.6060809@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On 03.01.2012 13:48, Igor Grinberg wrote:
>> I will forward this info to hardware guys and ask about wiring. For now
>> I will leave it as is. Thanks for this information it turned to be some
>> kind of mystery. It would be great if you could give some pointer to the
>> datasheet regarding VDDSHV and DSS.
> 
> Well, there is no direct pointer to that information, but
> I've found these facts:
> 1) the "Ball Characteristics" tables state that the DSS related pins
>    (and also many others) are powered by the VDDSHV.
> 2) the estimated power consumption of VDDSHV is the largest after the
>    VDD_CORE, which is typical for DSS, but it is also one of the largest
>    power domains, so I guess this cannot be a valid argument ;-)
> 3) On the "Voltage domains" diagram, only the VDD_CORE is exposed and
>    DSS is not listed in it, but there are other domains which are not
>    exposed... (this only can exclude the DSS from VDD_CORE, but not
>    absolutely, as datasheets can have mistakes or just not give that piece
>    of information).
> 
> Still, it is a guess and not verified information.

Yes, I understand. Thanks for sharing you thoughts!

Regards, Ilya.
