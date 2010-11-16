From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 22:23:41 +0000
Subject: [PATCH v5 01/12] misc: add driver for sequencer serial port
In-Reply-To: <AANLkTik76EY8Xh01YP2Tep6k1ETPO+3idmNuk3pVikJG@mail.gmail.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-2-git-send-email-cyril@ti.com>
	<20101116071047.GE4074@angua.secretlab.ca>
	<4CE2AE3C.4040805@ti.com>
	<AANLkTik76EY8Xh01YP2Tep6k1ETPO+3idmNuk3pVikJG@mail.gmail.com>
Message-ID: <20101116222340.GF21926@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 01:35:40PM -0700, Grant Likely wrote:
> I'll let Russel make the decision here; but I must admit I'm puzzled.
                 ^
Grr.

I'm ambivalent over it, provided that the author realises that the
__raw variants have no ordering guarantees other than their accesses
being ordered only with respect to themselves and nothing else.

If we do want to go down the route of creating some official native
endian accessors, then I'm fine with that too.
