From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2018 09:10:23 -0700
Subject: Regression in next with filesystem context concept
In-Reply-To: <9053.1536310046@warthog.procyon.org.uk>
References: <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
Message-ID: <20180907161023.GF5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* David Howells <dhowells@redhat.com> [180907 08:51]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Looks like next-20180906 now has a regression where mounting
> > root won't work with commit fd0002870b45 ("vfs: Implement a
> > filesystem superblock creation/configuration context").
> 
> Am I right in thinking you're not using any of the LSMs?

Assuming LSM as in Documentation/lsm.txt, right not using any.

BTW, I don't think this issue shows up with ramdisk either,
so that's probably why for example kernelci.org does not
show errors.

Regards,

Tony
