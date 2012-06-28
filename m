From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 28 Jun 2012 22:33:06 +1000
Subject: [GIT PULL] PWM subsystem
In-Reply-To: <20120621083650.GA2529@avionic-0098.mockup.avionic-design.de>
References: <20120621083650.GA2529@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120628223306.1e6918316a6a5f65528ef63c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Thu, 21 Jun 2012 10:36:51 +0200 Thierry Reding <thierry.reding@avionic-design.de> wrote:
>
> The PWM subsystem patches have gone through a number of versions now and
> all outstanding issues have been resolved. I believe that the subsystem
> is ready for broader testing in linux-next. If all goes well I plan to
> submit it to Linus during the 3.6 merge window.
> 
> I am not aware of any dependencies in linux-next. The two patches that
> don't touch the PWM subsystem itself are OF related and have been acked
> by Rob Herring who prefers that I take them through the PWM tree.
> 
> Please contact me if there are any issues with the tree.
> 
> The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:
> 
>   Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-pwm/linux-pwm.git for-next
> 
> for you to fetch changes up to b5156ca503f9471449b941364bb2bc34fa355d5d:
> 
>   pwm: Take over maintainership of the PWM subsystem (2012-06-15 12:57:07 +0200)

I have added your tree now.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120628/c073099e/attachment-0001.sig>
