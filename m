From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Aug 2013 11:05:27 +0100
Subject: [PATCH v2] arm: update advice on kernel, initramfs and FDT
 load address.
In-Reply-To: <1377079147.31937.37.camel@hastur.hellion.org.uk>
References: <1375974974-31603-1-git-send-email-ian.campbell@citrix.com>
 <20130808215429.GG19383@mudshark.cambridge.arm.com>
 <1377079147.31937.37.camel@hastur.hellion.org.uk>
Message-ID: <20130821100526.GK17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 10:59:07AM +0100, Ian Campbell wrote:
> Unless there are any more comments on the correctness of the advice I
> suppose this should go via Russell's PTS? Now to dredge up the 8 year
> old memories of how that stuff works...

It's quite simple - with the standard git formatted email (iow, without
8<==== stuff or similar), just send it to the PTS address.

In other words, summary in the subject line, patch description in the
body along with the sign-off, the end-of-description marker, be that
the dashes or "PATCH FOLLOWS", and the patch following that.

The only additional thing that needs to be added is a "Kernelversion:"
tag to specify which kernel version the patch was generated against.
That can go almost anywhere in the message before the actual patch
itself.

Alternatively, if you can remember your web login etc, then you can use
the online form, which tries to make it easier (since it generates the
formatted email for you - but some people find this method harder.)
