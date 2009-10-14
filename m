From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Oct 2009 20:03:33 +0100
Subject: [PATCH 4/6] ARM: remove references to non-existent fastfpe
In-Reply-To: <200910142021.59118.peter@peter-teichmann.de>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
	<20091009165513.GA5902@n2100.arm.linux.org.uk>
	<4AD048A4.1070805@tuffmail.co.uk>
	<200910142021.59118.peter@peter-teichmann.de>
Message-ID: <20091014190333.GA28948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2009 at 08:21:58PM +0200, Peter Teichmann wrote:
> I agree to Alan. It seems reasonable at least to include a stub as he 
> suggests. However, since FastFPE was not updated for some years now, maybe 
> the burden of maintaining patches is not so heavy in anymore? Maybe we can 
> as well just include the latest version now? It becomes more and more 
> difficult to find the source for someone who is interested in it.

The easiest and least risky approach would be to leave it as is - we
know it's not causing any problems with it there, and it's not causing
any run-time bloat.
