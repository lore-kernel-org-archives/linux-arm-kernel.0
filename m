From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 25 Aug 2014 19:20:07 +0200
Subject: [PATCH v9 1/2] regulator: Add driver for max77802 PMIC PMIC
 regulators
In-Reply-To: <CAD=FV=V4TSKsbjj3dXCdSzVrh3sxH-FkpFEbEo+JA1bN9R-XWA@mail.gmail.com>
References: <1408350762-15520-1-git-send-email-javier.martinez@collabora.co.uk>	<1408350762-15520-2-git-send-email-javier.martinez@collabora.co.uk>	<CA+NduCDL65=Y=PyU3FfXsTz0FfbmYzicGrY4U7ji3_V+nXhtCQ@mail.gmail.com>	<53F73472.8010609@collabora.co.uk>	<20140822144531.GV24407@sirena.org.uk>	<53F7838F.8060906@collabora.co.uk>	<20140822183054.GY24407@sirena.org.uk>	<53F7BDD8.7060500@collabora.co.uk>	<CAD=FV=WC0h7fYm2QFqu3Zka7CsU4BtG-oyPpJav+ygC+gmCR+A@mail.gmail.com>	<CA+NduCCT-KQ=gh7QWkBE4qkA2YOJ8KCVqbkC6Tkmb1aPvCsGFQ@mail.gmail.com>	<53FAFCBC.2050407@collabora.co.uk>
 <CAD=FV=V4TSKsbjj3dXCdSzVrh3sxH-FkpFEbEo+JA1bN9R-XWA@mail.gmail.com>
Message-ID: <53FB7047.7080508@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 08/25/2014 05:40 PM, Doug Anderson wrote:
>>
>> I see, so probably until we have a way to define the operating mode for
>> each regulator using DT we should set the opmode to normal when enabling a
>> regulator independently of the value the hardware register reported on probe.
>>
>> Can you please test the following change [0] so I can post as a proper
>> patch? Doug, Mark do you think that forcing the regulator to opmode normal
>> when enabling is the right solution here?
> 
> IMHO that makes sense.
> 

Thanks, I'll post it as a proper patch tomorrow then.

Best regards,
Javier
