From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Oct 2015 14:29:52 +0200
Subject: "clk: sunxi: Add a simple gates driver" breaks kernel with older
 DTB
In-Reply-To: <560E6768.6040705@citrix.com>
References: <1443689231.16718.225.camel@citrix.com>
 <20151001204506.GR7104@lukather> <560E5767.2040502@citrix.com>
 <20151002105333.GA2696@lukather> <560E6768.6040705@citrix.com>
Message-ID: <20151005122952.GJ2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;3803;0c
On Fri, Oct 02, 2015 at 12:15:52PM +0100, Julien Grall wrote:
> On 02/10/15 11:53, Maxime Ripard wrote:
> >> If no, that's very unfortunate because it means that you can't
> >> re-use the same DT across multiple OS and the DT provided by the
> >> firmware (if it's built-in).
> > 
> > Is there such OS yet (and by that, I mean one that actually shares our
> > DT, instead of rewriting its own) ?
> 
> Yes, FreeBSD started to support the DT provided by vendors which are
> based on Linux bindings. The ARM64 port is only using DTB provided by
> the hardware. For ARM32, there is still some platform using a specific
> DT for FreeBSD but they are trying to get a ride.

Well, it would have been good if they contacted us in the first place
then, because this has never been considered seriously afaik, and we
never stated that it actually was an ABI.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/ec250fa7/attachment.sig>
