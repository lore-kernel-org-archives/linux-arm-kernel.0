From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Feb 2011 21:55:25 -0500 (EST)
Subject: [PATCH v4 7/7] dt: add documentation of ARM dt boot interface
In-Reply-To: <20110223022239.18318.87333.stgit@localhost6.localdomain6>
References: <20110223021524.18318.71902.stgit@localhost6.localdomain6>
	<20110223022239.18318.87333.stgit@localhost6.localdomain6>
Message-ID: <alpine.LFD.2.00.1102222149370.22028@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Feb 2011, Grant Likely wrote:

> +The boot loader must load a device tree image (dtb) into system ram
> +at a 64bit aligned address and initialize it with the boot data.
[...]
> +                r2 : physical pointer to the device-tree block
> +                (defined in chapter II) in RAM.  Device tree can be located
> +                anywhere in system RAM, but it should be aligned on a 32 bit
> +                boundary.

So... which one is true?


Nicolas
