From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Sep 2016 10:28:38 -0500
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
In-Reply-To: <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
 <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
 <4a199a95-3ee6-a3a0-bc8a-63bd0912e7d2@suse.de>
Message-ID: <20160916152838.GA6795@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 02:50:37PM +0200, Andreas F?rber wrote:
> Am 08.09.2016 um 14:04 schrieb Andreas F?rber:
> > Am 08.09.2016 um 09:53 schrieb Neil Armstrong:
> >> This patchset adds a specific compatible string in the Meson SPIFC driver for
> >> the Amlogic Meson GXBB SoC.
> > 
> > Any particular reason? We could just reuse the meson6 one since there
> > appear to be no code changes so far.
> 
> So Neil is essentially telling me they don't know whether there are any
> differences in the IP block, so a separate compatible string was chosen.
> 
> No objection from my side, but a general clarification from device tree
> maintainers when and when not to would be appreciated. (+ devicetree)

New chip, always define a new compatible. If you think they are the same 
or are close enough to function with the existing driver, then put both 
compatible strings in the DT.

Rob
