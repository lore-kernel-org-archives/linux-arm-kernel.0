From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 2 Aug 2013 15:54:07 -0400
Subject: [RFC PATCH V2 9/9] appended dtbs works!
In-Reply-To: <alpine.LFD.2.03.1308021537070.14472@syhkavp.arg>
References: <cover.1375457714.git.jason@lakedaemon.net>
 <ecbf213c41cfd68781dd362e01ee1e42e3d7dba9.1375457714.git.jason@lakedaemon.net>
 <alpine.LFD.2.03.1308021537070.14472@syhkavp.arg>
Message-ID: <20130802195407.GF5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 03:42:22PM -0400, Nicolas Pitre wrote:
> On Fri, 2 Aug 2013, Jason Cooper wrote:
> 
> > With this commit, the user can build a single binary with the zImage
> > linked in and the dtbs appended.
> 
> Do you mean that you can append a DTB to the resulting binary we call 
> the impedance matcher,

Yes.

> This project allows for turning off CONFIG_ARM_APPENDED_DTB and that 
> should probably be documented somewhere to avoid confusion.

Agreed.

A lot of folks can just use the generic config without writing
custom board code.  So, appended or addressed zImage, and addressed
single dtb.  Once the impedance-matcher has some more real-world
testing, should we look at deprecating CONFIG_ARM_APPENDED_DTB?

thx,

Jason.
