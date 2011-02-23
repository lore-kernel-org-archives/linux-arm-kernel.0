From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 24 Feb 2011 00:13:36 +0300
Subject: [PATCH v4 6/7] arm/dt: Basic tegra devicetree support
In-Reply-To: <20110223022234.18318.90592.stgit@localhost6.localdomain6>
References: <20110223021524.18318.71902.stgit@localhost6.localdomain6>
	<20110223022234.18318.90592.stgit@localhost6.localdomain6>
Message-ID: <4D657880.50405@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-02-2011 5:22, Grant Likely wrote:

> This patch adds adds very basic support for booting tegra with a
> device tree.  It simply allows the existing machine_descs to match
> against the tegra compatible values so that the kernel can boot.
> Kernel parameters and the initrd pointer is read out of the tree
> instead of atags.

> This is not complete device tree support.  This change will be
> reverted when a new machine_desc is added that can populate the
> device registrations directly from data in the tree instead of using
> hard coded data.  That change will be made in a future patch.

> v2: Fixed cut-and-paste error in commit text

    Shouldn't this sentence follow the --- tearline?

> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>

WBR, Sergei
