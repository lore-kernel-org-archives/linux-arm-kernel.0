From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 10:29:55 +0000
Subject: [PATCH 0/7] dma-mapping: Cortex A9 speculative prefetch fixes
In-Reply-To: <20091121140037.GI6741@wear.picochip.com>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
	<20091121140037.GI6741@wear.picochip.com>
Message-ID: <20091123102955.GB16050@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 02:00:37PM +0000, Jamie Iles wrote:
> On Fri, Nov 20, 2009 at 06:25:39PM +0000, Russell King - ARM Linux wrote:
> > An equivalent patch has been tested by a couple of folk who now
> > report success.  Here's the refined patch set.  Acks, further
> > testing, and tested-by stuff welcome.
> Tested against 2.6.32-rc8 on an ARM1176JZ-S platform and this fixes the issues
> that we were seeing.
> 
> Tested-By: Jamie Iles <jamie@jamieiles.com>

Thanks Jamie.  We're a little too late for 2.6.32, but it'll be merged
during the post 2.6.32 window.
