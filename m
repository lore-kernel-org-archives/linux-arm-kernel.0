From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 8 Sep 2016 14:50:37 +0200
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
In-Reply-To: <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
 <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
Message-ID: <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.09.2016 um 14:04 schrieb Andreas F?rber:
> Am 08.09.2016 um 09:53 schrieb Neil Armstrong:
>> This patchset adds a specific compatible string in the Meson SPIFC driver for
>> the Amlogic Meson GXBB SoC.
> 
> Any particular reason? We could just reuse the meson6 one since there
> appear to be no code changes so far.

So Neil is essentially telling me they don't know whether there are any
differences in the IP block, so a separate compatible string was chosen.

No objection from my side, but a general clarification from device tree
maintainers when and when not to would be appreciated. (+ devicetree)

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
