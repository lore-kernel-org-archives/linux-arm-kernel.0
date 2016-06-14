From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 Jun 2016 09:59:40 +0900
Subject: [RESEND PATCH 0/2] arm64: dts: r8a7795: Add FCPF and FDP1 device
 nodes
In-Reply-To: <1465491418-32752-1-git-send-email-kieran@bingham.xyz>
References: <1465491418-32752-1-git-send-email-kieran@bingham.xyz>
Message-ID: <20160614005940.GD6456@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 05:56:56PM +0100, Kieran Bingham wrote:
> Appologies for the resend, I very cleverly sent this cover letter detailing the
> dependencies only to my e-mail address. And I already know the dependencies!
> 
> Following two patches are the same, sorry for the noise.
> 
> These are dependent upon the FCP bindings from Laurent [0], and the FCPF
> update to those bindings from me [1], and of course the bindings for the
> FDP1 [2] which are all posted separately.
> 
> [0] http://www.spinics.net/lists/devicetree/msg123968.html
> [1] https://lkml.org/lkml/2016/6/9/291
> [2] https://lkml.org/lkml/2016/6/9/294

These patches look good to me. My assumption is that they
can be applied without causing any breakage and that the
relevant features will start working once driver support
shows up in the kernel.

If the above assumption is correct then please let me know when the
bindings have been accepted by the relevant subsystem maintainer(s).

If the patches need rebasing at that time then please repost them.
Otherwise you can either repost them or ping me as a response to this thread.

Thanks!
