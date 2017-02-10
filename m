From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 10 Feb 2017 15:40:34 +0300
Subject: [PATCH] staging: vc04_services: remove unused functions
In-Reply-To: <78243491.gCbftNnyIb@wuerfel>
References: <20170207115308.5208-1-alexander@alemayhu.com>
 <20170207120943.GC11154@mwanda> <78243491.gCbftNnyIb@wuerfel>
Message-ID: <20170210123928.GA4162@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 11:42:21AM +0100, Arnd Bergmann wrote:
> On Tuesday, February 7, 2017 3:09:44 PM CET Dan Carpenter wrote:
> > There is a bunch of vc04_services that we're still looking to merge in
> > the near future.  Please hold off deleting these until we are further
> > along on that.
> > 
> 
> More generally speaking, I'd like to see all the 
> -Wmissing-declarations/-Wmissing-prototypes warnings addressed
> in the kernel and turn on that warning by default.
> 
> If there are parts of vc04_services that are intentionally
> left in place but currently unused, adding a declaration in the
> header file with a comment should be sufficient to prevent it
> from getting deleted or seeing bogus warnings.

Yeah.  That's true.  There really isn't a good reason to have these
warnings.

regards,
dan carpenter
