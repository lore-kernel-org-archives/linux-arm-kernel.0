From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 16 Jul 2015 19:25:38 +0200 (CEST)
Subject: [PATCH 0/5] arm64, pci: Add ECAM/PCIe support for Cavium ThunderX
In-Reply-To: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <alpine.DEB.2.11.1507161924270.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jul 2015, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The subject pretty much says it all.  The first four patches tweak the
> infrastructure a little so that we can get required behavior.  The

Just that you avoid to describe what the required behaviour is.

Can you please provide a proper description how this looks like from
the HW side and how you want to map that into software?

Thanks,

	tglx
