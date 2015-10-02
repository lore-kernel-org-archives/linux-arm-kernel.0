From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 2 Oct 2015 12:15:52 +0100
Subject: "clk: sunxi: Add a simple gates driver" breaks kernel with older
 DTB
In-Reply-To: <20151002105333.GA2696@lukather>
References: <1443689231.16718.225.camel@citrix.com>
 <20151001204506.GR7104@lukather> <560E5767.2040502@citrix.com>
 <20151002105333.GA2696@lukather>
Message-ID: <560E6768.6040705@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 11:53, Maxime Ripard wrote:
>> If no, that's very unfortunate because it means that you can't
>> re-use the same DT across multiple OS and the DT provided by the
>> firmware (if it's built-in).
> 
> Is there such OS yet (and by that, I mean one that actually shares our
> DT, instead of rewriting its own) ?

Yes, FreeBSD started to support the DT provided by vendors which are
based on Linux bindings. The ARM64 port is only using DTB provided by
the hardware. For ARM32, there is still some platform using a specific
DT for FreeBSD but they are trying to get a ride.

Regards,

-- 
Julien Grall
