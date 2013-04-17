From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 17 Apr 2013 10:02:33 +1000
Subject: adding rpmsg.git to linux next
In-Reply-To: <CAK=WgbbVP+3eugev8szRBCV84uZLdKP6QXAH_Fr89SXDs-V5GQ@mail.gmail.com>
References: <CAK=WgbY=4rosYr2g3fYYk6WrqXjN7f=5Dk5+D-h3cWrOtVmNag@mail.gmail.com>
 <20130416100715.cd726b96944237ef975ebe7d@canb.auug.org.au>
 <CAK=WgbbVP+3eugev8szRBCV84uZLdKP6QXAH_Fr89SXDs-V5GQ@mail.gmail.com>
Message-ID: <20130417100233.a31e740ec21c96150fde0d81@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Tue, 16 Apr 2013 20:51:13 +0300 Ohad Ben-Cohen <ohad@wizery.com> wrote:
>
> On Tue, Apr 16, 2013 at 3:07 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Mon, 15 Apr 2013 09:28:17 +0300 Ohad Ben-Cohen <ohad@wizery.com> wrote:
> >> Could you please add:
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git#for-next
> >>
> >> to linux-next to include new stuff coming from Rob?
> >
> > Well, you could tell me something about it.  Like what is in it and how
> > it will be merged up to Linus.  Does this have anything to do with the
> > remoteproc tree I already include?  Who is the official maintainer (there
> > is no mention of drivers/rpmsg in the MAINTAINERS file).
> 
> Sorry for not mentioning this.
> 
> This tree isn't new and is being used to send pull requests to Linus
> for some time. I guess that most (all?) of the pull requests contained
> fixes which needed no linux-next presence, so it never occurred to me
> the tree isn't part of linux-next.

All good, thanks for the explanation.  I have added that tree from today.

> commit d8115db52b99eefb99bcbf992edc349e691b4ca7
> Author: Ohad Ben-Cohen <ohad@wizery.com>
> Date:   Tue Apr 16 20:34:49 2013 +0300
> 
>     MAINTAINERS: add rpmsg entry
> 
>     People and scripts look for this.
> 
>     Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Good idea.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130417/6b35f1b5/attachment.sig>
