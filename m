From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 17:43:30 +0000
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <CAA3XUr0yr0Vh_rpM7bKJGBkOpWhOarUs=pRAx40mwqRp2V=mfg@mail.gmail.com>
References: <20131018205405.GA28835@codethink.co.uk>
 <20131019170954.GC25076@mudshark.cambridge.arm.com>
 <5262E2C7.7000106@codethink.co.uk>
 <20131028004736.GG16735@n2100.arm.linux.org.uk>
 <20131028084455.GA20218@mudshark.cambridge.arm.com>
 <20131028085328.GI16735@n2100.arm.linux.org.uk>
 <526E89E6.8010202@codethink.co.uk>
 <CAA3XUr0yr0Vh_rpM7bKJGBkOpWhOarUs=pRAx40mwqRp2V=mfg@mail.gmail.com>
Message-ID: <20131030174329.GJ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 09:05:09PM -0700, Victor Kamensky wrote:
> I just fetched rmk/for-next as of 10/29/2013 8pm PST. I see that big
> endian patch series is in. I believe conflict resolution 580dac83 in head.S
> is correct. I've added typo and .align fix as in [1] to head.S and
> tested BE image on TC2 in both ARM and THUMB2 modes - both boot
> and look fine to me.

Although it's in for-next, I won't be pushing the series until we know
that there are no known problems - so we need to get the patch you refer
to in as well along side it.
