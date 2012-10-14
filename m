From: zonque@gmail.com (Daniel Mack)
Date: Sun, 14 Oct 2012 16:44:15 -0000
Subject: [revert request for commit 9fff2fa] Re: [git pull] signals pile 3
In-Reply-To: <20121014164020.GV2616@ZenIV.linux.org.uk>
References: <20121013005334.GM2616@ZenIV.linux.org.uk>
 <507ADBBB.9090209@gmail.com>
 <20121014164020.GV2616@ZenIV.linux.org.uk>
Message-ID: <CACTFLAOpcLtHNx-TCHQkUOPNAkTO8EgDhbyZSGQ9ag+Wu_cNRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 14, 2012 6:40 PM, "Al Viro" <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Oct 14, 2012 at 05:35:23PM +0200, Daniel Mack wrote:
>
> > I rebased my ARM development branch and figured that your patch 9fff2fa
> > ("arm: switch to saner kernel_execve() semantics") breaks the boot on my
> > board right after init is invoked via NFS:
>
> OK, revert it is, then.  Nothing in the tree has dependencies on that
sucker
> and while it survives testing here, it's obviously not ready for mainline.
> So, with abject apologies to everyone involved, please revert.

Reverting it is not straight forward, and half of this patch doesn't seem
to cause issues.

I can resend my patch with an S-o-b if you want me to.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121014/0fc4e6e4/attachment-0001.html>
