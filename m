From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 14:22:01 +0100
Subject: [PATCH 0/2] kuser helpers documentation cleanup and 64-bit cmpxchg
In-Reply-To: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
References: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
Message-ID: <20110620132150.GA6310@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2011 at 12:54:52PM -0400, Nicolas Pitre wrote:
> This series cleans up the kuser documentation, then it adds 64-bit
> cmpxchg support as needed by some user space applications.
> 
> [PATCH 1/2] ARM: kuser: move interface documentation out of the source code
> [PATCH 2/2] ARM: add a kuser_cmpxchg64 user space helper

Hi again,

It looks like these patches apply on top of my
'ARM: kuser helpers: comment cleanup' patch, which didn't receive any
comments or acks and hasn't been merged.

Are you happy to ack that patch, or did you merge a modified version on
your side?

If you want to roll the relevant changes into your series, I'm happy
with that too.

Cheers
---Dave
