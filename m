From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Nov 2009 00:16:49 +0000
Subject: [PATCH 06/10] ARM: dma-mapping: move consistent_init into
	CONFIG_MMU section
In-Reply-To: <4B088054.30606@snapgear.com>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
	<E1NBvmz-0007qr-7X@rmk-PC.arm.linux.org.uk>
	<4B088054.30606@snapgear.com>
Message-ID: <20091122001649.GH13956@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2009 at 10:05:40AM +1000, Greg Ungerer wrote:
>
> Hi Russell,
>
> Russell King - ARM Linux wrote:
>> No point wrapping the contents of this function with #ifdef CONFIG_MMU
>> when we can place it and the core_initcall() entirely within the
>
> Lost the end of the comments here?

Yes, it should have one more line.  "existing conditional block."
