From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 19 Jan 2011 15:14:12 +0300
Subject: [PATCH 8/8] arm/dt: Basic tegra devicetree support
In-Reply-To: <20110118202938.13011.35918.stgit@localhost6.localdomain6>
References: <20110118195933.13011.56098.stgit@localhost6.localdomain6>
	<20110118202938.13011.35918.stgit@localhost6.localdomain6>
Message-ID: <4D36D594.3010909@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-01-2011 23:29, Grant Likely wrote:

> This patch adds adds

    One word is enough. :-)

> very basic support for booting versatile with a
> device tree.  It simply allows the existing machine_descs to match
> against the tegra compatible values so that the kernel can boot.
> Kernel parameters and the initrd pointer is read out of the tree
> instead of atags.

> This is not complete device tree support.  This change will be
> reverted when a new machine_desc is added that can populate the
> versatile device registrations directly from data in the tree instead
> of using hard coded data.  That change will be made in a future patch.

> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>

WBR, Sergei
