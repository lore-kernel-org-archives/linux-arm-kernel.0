From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 20:57:01 +0100
Subject: [PATCH] ARM: integrator: Make sure INTEGRATOR_AP depends on PCI
In-Reply-To: <1376509818-22163-1-git-send-email-joro@8bytes.org>
References: <1376509818-22163-1-git-send-email-joro@8bytes.org>
Message-ID: <20130814195701.GY23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 09:50:18PM +0200, Joerg Roedel wrote:
> Add this dependency to the Kconfig file to fix the following
> build error when CONFIG_INTEGRATOR_AP is set but CONFIG_PCI
> is not:

No, integrator does not require PCI, so this needs to be fixed by other
means, such as finding out how the breakage was introduced, and fixing
the real cause of this regression.
