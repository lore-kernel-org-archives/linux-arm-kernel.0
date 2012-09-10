From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 11 Sep 2012 09:26:14 +1000
Subject: Another tree for "next"
In-Reply-To: <504E28CE.6020103@wwwdotorg.org>
References: <m3obli3j7a.fsf@intrepid.localdomain>
 <20120910100144.dcbe2715cde0fea51345a354@canb.auug.org.au>
 <m31ui9g4ff.fsf@intrepid.localdomain>
 <504E28CE.6020103@wwwdotorg.org>
Message-ID: <20120911092614.d42403c55b516ea898fb5e21@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Mon, 10 Sep 2012 11:52:14 -0600 Stephen Warren <swarren@wwwdotorg.org> wrote:
>
> On 09/10/2012 11:42 AM, Krzysztof Halasa wrote:
> > Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > 
> >>> could you please add the following to your "next" tree?
> >>>
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux.git  branch: next
> > 
> >> Could you be a bit more clear about what will be in that tree, please?
> >> Also when you repost this request, please post it a bit more widely among
> >> other people/lists who may be interested in this work.  Remember that
> >> linux-next is really only for stuff that is ready for Linus to pull into
> >> the next merge window (or bug fixes).  Also, would this tree be pulled
> >> directly by Linus, or via some other tree?
> > 
> > My plan is to merge all the stuff I'm (eventually) working on in the
> > above tree. For now - mostly IXP4xx (ARM CPU etc.) stuff which goes to
> > Linus
> 
> ARM-SoC-related pull requests should be sent to the arm-soc tree, who
> will then aggregate all the ARM-SoC-related changes and issue pull
> requests to Linus.
> 
> That is, arm at kernel.org, plus the Linux ARM kernel list CC'd.
> 
> The patches would also need to be sent to the Linux ARM kernel list (and
> any other relevant lists) before being applied to your tree.
> 
> ARM core changes would likely go through Russell King's tree, perhaps
> depending on what dependencies they have.

OK, I have added your tree from today.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/aa068b86/attachment.sig>
