From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 23 Feb 2011 14:36:01 -0700
Subject: [PATCH v4 6/7] arm/dt: Basic tegra devicetree support
In-Reply-To: <4D657880.50405@ru.mvista.com>
References: <20110223021524.18318.71902.stgit@localhost6.localdomain6>
	<20110223022234.18318.90592.stgit@localhost6.localdomain6>
	<4D657880.50405@ru.mvista.com>
Message-ID: <20110223213601.GA5404@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24, 2011 at 12:13:36AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 23-02-2011 5:22, Grant Likely wrote:
> 
> >This patch adds adds very basic support for booting tegra with a
> >device tree.  It simply allows the existing machine_descs to match
> >against the tegra compatible values so that the kernel can boot.
> >Kernel parameters and the initrd pointer is read out of the tree
> >instead of atags.
> 
> >This is not complete device tree support.  This change will be
> >reverted when a new machine_desc is added that can populate the
> >device registrations directly from data in the tree instead of using
> >hard coded data.  That change will be made in a future patch.
> 
> >v2: Fixed cut-and-paste error in commit text
> 
>    Shouldn't this sentence follow the --- tearline?

Nope!  It is actually quite useful for the version information to show
up in the commit text.  That way you know *exactly* which version got
merged.  dwmw2 pointed that out to me a few months back.
