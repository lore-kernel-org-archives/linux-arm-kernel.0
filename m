From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 03 May 2016 21:22:05 +0200
Subject: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
In-Reply-To: <20160503115159.GP6292@sirena.org.uk> (Mark Brown's message of
 "Tue, 3 May 2016 12:51:59 +0100")
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
Message-ID: <87y47roski.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Sat, Apr 30, 2016 at 11:15:33PM +0200, Robert Jarzmik wrote:
>> Split out from the ac97_codec.h the ac97 generic registers, which can be
>> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
>> scan an ac97 AC-Link.
>
> I don't entirely see the value in this one but equally it does no harm.
Oh that's to have the defines AC97_VENDOR_ID1 and AC97_VENDOR_ID2, but without
including ac97_codec.h in sound/ac97/bus.c.

Cheers.

-- 
Robert
