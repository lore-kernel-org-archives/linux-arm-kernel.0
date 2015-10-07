From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 07 Oct 2015 21:49:33 +0200
Subject: [PATCH v4 19/26] ARM: pxa: magician: Add support for Omnivision
 OV9640 camera
In-Reply-To: <1443876607.4186.35.camel@gmail.com> (Philipp Zabel's message of
 "Sat, 03 Oct 2015 14:50:07 +0200")
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B365.4060307@tul.cz>
 <1443876607.4186.35.camel@gmail.com>
Message-ID: <87pp0qa27m.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

> Am Montag, den 28.09.2015, 23:38 +0200 schrieb Petr Cvek:
>> This patch adds support for an OV9640 camera to the HTC Magician
>> machine.
>> 
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>
> Still untested, but looks good to me.
I'm still reluctant to have the reset with the timings handled in the board code
as I consider this should be in the camera driver code
(magician_camera_reset()).

Cheers.

-- 
Robert
