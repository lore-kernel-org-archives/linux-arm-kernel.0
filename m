From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 23 Aug 2013 22:11:49 +0200
Subject: [PATCH] misc: (at24) move header to linux/platform_data/
In-Reply-To: <1033284781.908504.1377285587778.JavaMail.root@mail>
References: <20130823190247.GA3821@katana>
 <1033284781.908504.1377285587778.JavaMail.root@mail>
Message-ID: <20130823201149.GA5640@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > This message explains what the patch does but not why the change is
> > wanted. I'd be surprised if we really want *all* platform_data in one
> > single directory?
> 
> IMHO it makes sense. Why wouldn't we want all platform_data in
> include/linux/platform_data/?

For the same reason we don't want all driver source files in one
directory? It's a mess.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/c221208d/attachment.sig>
