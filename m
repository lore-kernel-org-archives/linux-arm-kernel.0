From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 17:41:37 +0200
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.9
In-Reply-To: <7h7fat25g4.fsf@baylibre.com>
References: <7h7fat25g4.fsf@baylibre.com>
Message-ID: <9855488.GIzjicgLjX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 2, 2016 5:27:23 PM CEST Kevin Hilman wrote:
> The pull request below is for the DT changes for 64-bit Amlogic
> platforms.
> 
> The DT additions for the new clock/reset support are dependent on DT
> bindings/includes that were merged via the clock tree, so this branch
> includes a merge of an immtable branch (clk/clk-gxbb-meson-ao) from the
> clock tree to handle those dependencies.
> 
> Due to the dependency, it's fine with me if this goes into next/late
> instead of next/dt64.
> 

Pulled into next/late, thanks!

	Arnd
