From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 16:03:32 +0000
Subject: [PATCH] ARM: l2c: enforce use of cache-level property
In-Reply-To: <1425408941-9897-1-git-send-email-f.fainelli@gmail.com>
References: <1425408941-9897-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150309160332.GU8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 10:55:41AM -0800, Florian Fainelli wrote:
> Make sure that we can read the "cache-level" property from the L2 cache
> controller node, and ensure its value is 2.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Russell, Linus,
> 
> You may have seen that patch earlier, it was part of my attempt
> to parse the 'cache-size' and 'cache-sets' properties, and ultimately
> Linus' series went it, and this patch was lost ast see.

Can you put it in the patch system please, and I'll get around to it
once at some point during/after I've finished catching up?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
