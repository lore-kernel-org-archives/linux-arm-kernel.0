From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 19:52:45 +0800
Subject: [PATCH] ARM: i.MX53 Add the cko1, cko2 clock outputs.
In-Reply-To: <20130319165701.27591.1287.stgit@localhost>
References: <20130319165701.27591.1287.stgit@localhost>
Message-ID: <20130402115242.GD27148@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 05:57:01PM +0100, Martin Fuzzey wrote:
> These two clocks connect to external pins and can be muxed to
> various internal clocks.
> They are typically used either for debugging or to provide
> clocks to external chips (eg audio codecs).
> 
> Currently only the selectable clocks that already exist in the clock tree
> have been added.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

Applied, thanks.
