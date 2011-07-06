From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 12:05:22 +0100
Subject: [PATCH 2/3] ARM: CSR: mapping early DEBUG_LL uart
In-Reply-To: <1309945678-18813-3-git-send-email-bs14@csr.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-3-git-send-email-bs14@csr.com>
Message-ID: <20110706110522.GQ8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:47:57AM -0700, Barry Song wrote:
> Signed-off-by: Barry Song <bs14@csr.com>

Surely this should be part of the first patch, which won't build without
this one if DEBUG_LL is enabled?
