From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 18:43:09 +0000
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131118161151.GG16735@n2100.arm.linux.org.uk>
References: <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <CAF6AEGtt_2sStiZCNBp9btxevWghSwLZZBdN6ir8eUpX1FXrCQ@mail.gmail.com>
 <20131024072811.GS30088@pengutronix.de>
 <CAF6AEGuEho9Ms7ifTE-EmBoQ-=_AXgvGcJxi5qEC0vsZ+H9C+A@mail.gmail.com>
 <20131118124518.GA16735@n2100.arm.linux.org.uk>
 <20131118153750.GM26046@ulmo.nvidia.com>
 <20131118161151.GG16735@n2100.arm.linux.org.uk>
Message-ID: <20131118184309.GU2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 04:11:51PM +0000, Russell King - ARM Linux wrote:

> Logically, it can't stay as two separate patches, because it won't be
> possible to "migrate" to it in stages.  So I'm fully intending to
> squash that all down to one patch which adds the core code (probably
> ultimately into drivers/base).

> IOW, watch this space this week. :)

Can you CC me on these changes please and I'll have a look at converting
ASoC over to use them?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/1f75b9b6/attachment.sig>
