From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 25 Mar 2010 18:46:02 -0400 (EDT)
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1003251843320.694@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Mar 2010, Daniel Walker wrote:

> These are all mostly small patches that I've sent out a few times with
> no comments. Let me know if you see any issues.
> 
> The following changes since commit 7ee744f22ffad619e23912a22d1b2795e10ed825:
>   Stephen Rothwell (1):
>         Add linux-next specific files for 20100324

Never base your tree on linux-next.  You really should use a stable 
tree, such as Linus' tree.  The linux-next tree is constantly thrown 
away and rebuilt, and your own tree will keep a reference on that 
obsoleted linux-next version otherwise.



Nicolas
