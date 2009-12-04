From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 17:24:17 +0000
Subject: [RFC PATCH 01/10] PCMCIA: soc_common: convert to a stand alone
	module
In-Reply-To: <4B194458.6040403@cam.ac.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
	<4B194458.6040403@cam.ac.uk>
Message-ID: <20091204172417.GE20386@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 05:18:16PM +0000, Jonathan Cameron wrote:
> Hi Russell,
> 
> This one is causing me some build problems.

Well, I've no idea what's happened to Dominik.  While I may be the
author of these patches, I didn't commit them, so they're out of my
control.

There are some outstanding merge issues which SFR identified, and so
far Dominik has been quiet on them.

For the time being, I'll merge your patch into my git tree, but unless
Dominik hands my patches back to me for merging, it will be lost.
