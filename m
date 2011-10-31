From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 11:06:36 +0000
Subject: [PATCH] mach-ixp4xx: made gpio functions atomic
In-Reply-To: <CACW_hTY_CCSMWK1tYK_or5g5-2NQUbfLiJxLhKvT=V8BPuODMg@mail.gmail.com>
References: <1319973693-19063-1-git-send-email-fransmeulenbroeks@gmail.com>
	<20111030185208.GD19187@n2100.arm.linux.org.uk>
	<CACW_hTY_CCSMWK1tYK_or5g5-2NQUbfLiJxLhKvT=V8BPuODMg@mail.gmail.com>
Message-ID: <20111031110635.GH19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 09:32:55AM +0100, Frans Meulenbroeks wrote:
> May I consider the patch accepted or is some rework needed?

Neither, I was just commenting on it.  MAINTAINERS says:

ARM/INTEL IXP4XX ARM ARCHITECTURE
M:      Imre Kaloz <kaloz@openwrt.org>
M:      Krzysztof Halasa <khc@pm.waw.pl>
L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      arch/arm/mach-ixp4xx/

It would be a good idea to have acks from Imre and/or Krzysztof, even
better if they can apply it themselves.
