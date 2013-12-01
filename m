From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 18:40:03 -0500
Subject: [PATCH V5] kbuild: dtbs_install: new make target
In-Reply-To: <653B066B-5B24-4817-86EF-D4D9F129123D@codeaurora.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385062552-9882-1-git-send-email-jason@lakedaemon.net>
 <653B066B-5B24-4817-86EF-D4D9F129123D@codeaurora.org>
Message-ID: <20131201234003.GF2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kumar,

On Thu, Nov 21, 2013 at 05:31:49PM -0600, Kumar Gala wrote:
> On Nov 21, 2013, at 1:35 PM, Jason Cooper <jason@lakedaemon.net> wrote:
...
> > #
> > +# INSTALL_DTBS_PATH specifies a prefix for relocations required by build roots.
> > +# Like INSTALL_MOD_PATH, it isn't defined in the Makefile, but can be passed as
> > +# an argument if needed.
> > +#
> 
> Nit, do we want to match INSTALL_MOD_PATH and drop the ?S? for INSTALL_DTB_PATH?

I thought about this, and I prefer to keep the S.  Installing one
module sounds silly, while installing one dtb implies we are doing
something we aren't.  Namely selecting the correct dtb.

thx,

Jason.
