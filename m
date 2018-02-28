From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 14:55:07 +0800
Subject: [PATCH 1/2] clk: imx: imx7d: add the Keypad Port module clock
In-Reply-To: <20180227160544.11446-1-stefan@agner.ch>
References: <20180227160544.11446-1-stefan@agner.ch>
Message-ID: <20180228065506.GK3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 05:05:43PM +0100, Stefan Agner wrote:
> According to the i.MX7D Reference Manual, the Keypad Port module
> (KPP) requires this clock gate to be enabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both.  But for future i.MX clock patches, please also copy
clk maintainers to give them chance to comment.

Michael Turquette <mturquette@baylibre.com>
Stephen Boyd <sboyd@kernel.org>

I will eventually need to send i.MX clock patches to them.

Shawn
