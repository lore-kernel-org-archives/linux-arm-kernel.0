From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Aug 2012 07:11:42 +0200
Subject: [PATCH] ARM: Build dtb files in all target
In-Reply-To: <503DC2D7.2080107@codeaurora.org>
References: <1346218523-15958-1-git-send-email-andrew@lunn.ch>
 <503DC2D7.2080107@codeaurora.org>
Message-ID: <20120830051142.GO9886@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 12:20:55AM -0700, Stephen Boyd wrote:
> On 8/28/2012 10:35 PM, Andrew Lunn wrote:
> > Tools like kisskb are good at finding build regressions in the kernel
> > sources. However, regressions in the DT desscriptions are not found,
> > because generally these build systems don't build the DT binary blobs.
> >
> > Extend the ARM all target to build all enabled DTB files.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> You should probably put a star (*) next to the dtbs info in the help
> text too.

Will do. Version 2 to be posted soon.

> 
> Have you tried this in a clean tree?

I tested with
make distclean
make kirkwood_defconfig
make

Any other permutations you would like me to test?

> Also, should this only be default true if USE_OF is true?

Also in v2.

     Thanks
          Andrew
