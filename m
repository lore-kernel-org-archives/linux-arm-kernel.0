From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 May 2015 17:18:12 +0100
Subject: [RFC PATCH] ARM: add fixmap based earlycon support
In-Reply-To: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150501161812.GN12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 03:51:48PM +0200, Ard Biesheuvel wrote:
> This adds support for fixmap based earlycon by moving the fixmap
> initialization to an earlier stage and introducing the Kconfig symbol
> that wires up the existing code.

I don't see the patches for this fixmap based earlycon.  What's the
status of those, and how are they getting into mainline?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
