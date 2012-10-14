From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sun, 14 Oct 2012 17:40:20 +0100
Subject: [revert request for commit 9fff2fa] Re: [git pull] signals pile 3
In-Reply-To: <507ADBBB.9090209@gmail.com>
References: <20121013005334.GM2616@ZenIV.linux.org.uk>
 <507ADBBB.9090209@gmail.com>
Message-ID: <20121014164020.GV2616@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2012 at 05:35:23PM +0200, Daniel Mack wrote:

> I rebased my ARM development branch and figured that your patch 9fff2fa
> ("arm: switch to saner kernel_execve() semantics") breaks the boot on my
> board right after init is invoked via NFS:

OK, revert it is, then.  Nothing in the tree has dependencies on that sucker
and while it survives testing here, it's obviously not ready for mainline.
So, with abject apologies to everyone involved, please revert.
