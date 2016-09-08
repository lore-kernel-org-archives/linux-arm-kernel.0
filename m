From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 8 Sep 2016 14:21:04 +0100
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
In-Reply-To: <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
 <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
 <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de>
Message-ID: <5f05c488-1889-057b-7068-8e070ff95611@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 13:50, Andreas F?rber wrote:
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

I prefer to add both the device-tree itself, so if there are differences
found later then it can be dealt with without rebuilding both the DT
and kernel.

It is nice to have the new ones added to the driver so that you know the
hardware choices in play.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
