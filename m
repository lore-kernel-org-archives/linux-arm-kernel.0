From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 17:45:09 +0200
Subject: [PATCH 00/15] ARM: sunxi: add A31 PL pins support
In-Reply-To: <20140409151747.GH28585@lukather>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <CAGb2v66XCN2ar1wj+a1+ZwdcdJ3gzJ+nDiO9bu52OwK+mBB_Hg@mail.gmail.com>
 <20140409151747.GH28585@lukather>
Message-ID: <20140409154509.GL28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 05:17:47PM +0200, Maxime Ripard wrote:
> > I have started to document the PRCM block: http://linux-sunxi.org/PRCM
> 
> It's quite different on the A31 and on the A23 actually :(
> 
> You don't have any of the audio thing for example, but you have the
> CPUs power clamp controls, that have been moved to the 

-that have been moved to the
+that have been removed in the A23

Sorry :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/6482ac98/attachment.sig>
