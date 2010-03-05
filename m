From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Fri, 5 Mar 2010 23:52:25 +0200
Subject: [PATCH] arm: convert /proc/cpu/aligment to seq_file
In-Reply-To: <20100305211212.GE4885@n2100.arm.linux.org.uk>
References: <20091127063746.GB25983@x200.malnet.ru>
	<20100305144523.GB23225@pengutronix.de>
	<20100305211212.GE4885@n2100.arm.linux.org.uk>
Message-ID: <20100305215225.GA4814@x200>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 09:12:12PM +0000, Russell King - ARM Linux wrote:
> The only reason it would be worth it is if we're getting rid of the
> old simple procfs PAGE_SIZE buffer interface.

This is exactly what is going on.
