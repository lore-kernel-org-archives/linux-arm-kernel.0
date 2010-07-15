From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 12:56:31 +0100
Subject: [PATCH 2/3] ARM: register character LCD for PB1176
In-Reply-To: <1278429678-4837-1-git-send-email-triad@df.lth.se>
References: <1278429678-4837-1-git-send-email-triad@df.lth.se>
Message-ID: <20100715115631.GG29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 06, 2010 at 05:21:18PM +0200, Linus Walleij wrote:
> This registers the character LCD device for the ARM RealView
> PB1176.

Shouldn't ARM_CHAR_LCD be a stand-alone option, rather than something
which is always built-in whenever one of these platforms is enabled?

If that link is broken, then these patches shouldn't depend on the first
and could be applied out of order.
