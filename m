From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 12:44:44 +0200
Subject: [PATCH v2 2/3] watchdog: qcom: document device tree bindings
In-Reply-To: <337231c0fc8b16b4f37e1e3b85cb0246f357a64d.1411513109.git.joshc@codeaurora.org>
References: <cover.1411513109.git.joshc@codeaurora.org>
 <337231c0fc8b16b4f37e1e3b85cb0246f357a64d.1411513109.git.joshc@codeaurora.org>
Message-ID: <2941802.u7NP2737aD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 18:04:37 Josh Cartwright wrote:
> +- clocks : shall contain the input clock phandle

Just nitpicking, but this is not just a phandle, it's a clock
descriptor, which is a phandle followed by a set of arguments,
which may be empty, depending the on the clock controller
implementation.

I would just call it 'the input clock', rather than 'input clock
phandle'.

	Arnd
