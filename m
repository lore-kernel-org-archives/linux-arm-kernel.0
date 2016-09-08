From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Sep 2016 11:17:08 -0700
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
In-Reply-To: <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Thu, 8 Sep 2016 14:50:37 +0200")
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
 <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
 <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de>
Message-ID: <m2r38umf2z.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Am 08.09.2016 um 14:04 schrieb Andreas F?rber:
>> Am 08.09.2016 um 09:53 schrieb Neil Armstrong:
>>> This patchset adds a specific compatible string in the Meson SPIFC driver for
>>> the Amlogic Meson GXBB SoC.
>> 
>> Any particular reason? We could just reuse the meson6 one since there
>> appear to be no code changes so far.
>
> So Neil is essentially telling me they don't know whether there are any
> differences in the IP block, so a separate compatible string was chosen.
>
> No objection from my side, but a general clarification from device tree
> maintainers when and when not to would be appreciated. (+ devicetree)

I'm not sure what the "right" way is (Rob?) but I think the usual way is
to add new compatibles when needed.

Kevin
