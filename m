From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Feb 2014 11:21:42 -0700
Subject: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <1392726043-31088-4-git-send-email-will.deacon@arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-4-git-send-email-will.deacon@arm.com>
Message-ID: <20140218182142.GF29304@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 12:20:43PM +0000, Will Deacon wrote:
> +
> +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> +    ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
                                           ^^^^^^^^^^^^^^

This probably shouldn't be 0 in the example, nor in your kvm tool
output. For example purposes any value will do.

Regards,
Jason
