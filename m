From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 8 Oct 2015 08:05:25 +0200
Subject: [PATCH v4 19/26] ARM: pxa: magician: Add support for Omnivision
 OV9640 camera
In-Reply-To: <87pp0qa27m.fsf@belgarion.home>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B365.4060307@tul.cz>
 <1443876607.4186.35.camel@gmail.com>
 <87pp0qa27m.fsf@belgarion.home>
Message-ID: <561607A5.50406@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 7.10.2015 v 21:49 Robert Jarzmik napsal(a):
> Philipp Zabel <philipp.zabel@gmail.com> writes:
> 
>> Am Montag, den 28.09.2015, 23:38 +0200 schrieb Petr Cvek:
>>> This patch adds support for an OV9640 camera to the HTC Magician
>>> machine.
>>>
>>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>>
>> Still untested, but looks good to me.
> I'm still reluctant to have the reset with the timings handled in the board code
> as I consider this should be in the camera driver code
> (magician_camera_reset()).

It supports an actual state of the OV9640 driver handling. But I can exclude it until
OV9640 will be transitioned. I don't have enough information about gpiod and soc-camera
and not enough time to maintain multiple different (and dependent) patchsets.

I forgot to test the timings ... actually I think I forgot results :-D . It was around the same time
I have found I2C fast mode is not working. Will test again.

Petr
