From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 09:45:14 +0800
Subject: [PATCH v2 3/3] ARM: vf610: Add ARM Global Timer clocksource option
In-Reply-To: <1411575610-20895-4-git-send-email-stefan@agner.ch>
References: <1411575610-20895-1-git-send-email-stefan@agner.ch>
 <1411575610-20895-4-git-send-email-stefan@agner.ch>
Message-ID: <20140926014513.GF21077@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 06:20:10PM +0200, Stefan Agner wrote:
> Add the ARM Global Timer as clocksource/scheduler clock option and
> use it as default scheduler clock. This leaves the PIT timer for
> other users e.g. the secondary Cortex-M4 core. Also, the Global Timer
> has double the precission (running at pheripheral clock compared to
> IPG clock) and a 64-bit incrementing counter register. We still keep
> the PIT timer as an secondary option in case the ARM Global Timer is
> not available.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
