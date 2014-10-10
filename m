From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Oct 2014 20:04:35 +0200
Subject: [Cocci] [RFC] drop owner assignment from platform_drivers
In-Reply-To: <alpine.DEB.2.10.1410100951250.2402@hadrien>
References: <20141010072439.GA1741@katana>
 <alpine.DEB.2.10.1410100951250.2402@hadrien>
Message-ID: <20141010180429.GA6075@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The semantic patch looks fine.

Wow, nothing to improve on the semantic patch? Now I am proud :) Thanks
Julia for your support, as always!

> If you think that it would be useful to have this in the Linux kernel, so
> people don't add the owner initializer back in the future, you can try
> 
> coccinelle/tools/sgen/sgen

Will try later this weekend, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/da5e35f1/attachment.sig>
