From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Aug 2013 09:12:12 +0900
Subject: [PATCH v6 0/3] R8A7778/BOCK-W R-Car VIN driver support
In-Reply-To: <201308230134.26092.sergei.shtylyov@cogentembedded.com>
References: <201308230134.26092.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130823001212.GE9254@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 01:34:25AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against the Mauro's 'media_tree.git' repo's
> 'master' branch. Here we add the VIN platform code working on
> the R8A7778/BOCK-W with ML86V7667 video decoder.
> 
> [1/3] ARM: shmobile: r8a7778: add VIN support
> [2/3] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support
> [3/3] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in defconfig
> 
>    Mauro has kindly agreed to merge this patchset thru his tree to resolve the
> dependency on the driver's platform data header, provided that the maintainer
> ACKs this. Simon, could you ACK the patchset ASAP -- Mauro expects to close his
> tree for 3.12 this weekend or next Monday?

Sure, all three patches:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
