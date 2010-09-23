From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Sep 2010 22:15:19 +0100
Subject: [PATCH] ARM: implement CONFIG_STRICT_DEVMEM by disabling
	access to RAM via /dev/mem
In-Reply-To: <alpine.LFD.2.00.1009231707300.13233@xanadu.home>
References: <alpine.LFD.2.00.1009231707300.13233@xanadu.home>
Message-ID: <20100923211519.GB26295@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 05:08:44PM -0400, Nicolas Pitre wrote:
> 
> There are very few legitimate use cases, if any, for directly accessing
> system RAM through /dev/mem.  So let's mimic what they do on x86 and
> forbid it when CONFIG_STRICT_DEVMEM is turned on.

Is this supposed to replace 6383/1 ?
