From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Dec 2012 18:03:48 +0000
Subject: [TRIVIAL PATCH 04/26] arm64: Convert print_symbol to %pSR
In-Reply-To: <c5cb06461153912fe383547a267aaea6e8b4976a.1355335227.git.joe@perches.com>
References: <cover.1355335227.git.joe@perches.com>
 <c5cb06461153912fe383547a267aaea6e8b4976a.1355335227.git.joe@perches.com>
Message-ID: <20121213180348.GD16532@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 06:18:53PM +0000, Joe Perches wrote:
> Use the new vsprintf extension to avoid any possible
> message interleaving.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
