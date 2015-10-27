From: slash.tmp@free.fr (Mason)
Date: Tue, 27 Oct 2015 14:31:38 +0100
Subject: Trustzone: DSB before/after SMC
Message-ID: <562F7CBA.7060806@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a few questions about SMC. (I'm using Cortex-A9)

Platforms that use SMC often/always execute DSB beforehand.

1a) Is DSB required before SMC?
1b) Is DSB required  after SMC?
2a) Is DSB required before returning to non-secure OS?
2b) Is DSB required  after returning to non-secure OS?
3) Is this documented in the ARM ARM?

Bonus question: if DSB is required before SMC, why didn't ARM
make SMC implicitly do a DSB?

Regards.
