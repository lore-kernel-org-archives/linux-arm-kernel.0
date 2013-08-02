From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 02 Aug 2013 15:42:22 -0400 (EDT)
Subject: [RFC PATCH V2 9/9] appended dtbs works!
In-Reply-To: <ecbf213c41cfd68781dd362e01ee1e42e3d7dba9.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
 <ecbf213c41cfd68781dd362e01ee1e42e3d7dba9.1375457714.git.jason@lakedaemon.net>
Message-ID: <alpine.LFD.2.03.1308021537070.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Aug 2013, Jason Cooper wrote:

> With this commit, the user can build a single binary with the zImage
> linked in and the dtbs appended.

Do you mean that you can append a DTB to the resulting binary we call 
the impedance matcher, or do you mean this supports the linking of a 
zImage with a DTB already appended?

If the later I'd recommend against 
supporting this.
If the former that's fine.

This project allows for turning off CONFIG_ARM_APPENDED_DTB and that 
should probably be documented somewhere to avoid confusion.


Nicolas
