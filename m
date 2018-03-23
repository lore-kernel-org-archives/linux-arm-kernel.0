From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 23 Mar 2018 09:51:53 +0100
Subject: linux-next: please clean up the alpine tree
In-Reply-To: <20180323083315.58976d73@canb.auug.org.au>
References: <20180323083315.58976d73@canb.auug.org.au>
Message-ID: <20180323085153.GB9682@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Mar 23, 2018 at 08:33:15AM +1100, Stephen Rothwell wrote:
> 
> The alpine tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/atenart/linux.git#alpine/for-next)
> only contains commits that have been upstreamed as different commits.
> It also hasn't been updated since late March 2017.  Please clean it up
> (it takes some time to merge - presumably just because of its age).
> 
> Or, if it is no longer being used, please let me know and I will remove
> it from linux-next.

Thanks for pointing this out, and sorry for the inconvenience. The
Alpine tree isn't very active and I haven't got patches for quite
some time.

I updated alpine/next to point to v4.16-rc1 to fix the issue. It's not
completely dead, but as it's not active you can also remove the
alpine/for-next tree from linux-next. And when/if I get patches to merge
in the future I'll ask to add it back. As you wish :)

Thank you for making linux-next!
Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
