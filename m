From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 10:29:09 +0000
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <20131031080326.GK24559@pengutronix.de>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
 <20131031080326.GK24559@pengutronix.de>
Message-ID: <20131031102908.GX16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 09:03:26AM +0100, Sascha Hauer wrote:
> So:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Ok, I'll wait for this to hit mainline before re-spinning the Carrier-1
DT files.  That's going to upset those who want to see Carrier-1 support
in mainline at the next merge window (like Olof) and out mainline support
for this board into 2014, but I don't see any other alternative.
