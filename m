From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 17:17:59 +0200
Subject: [PATCH 0/2] ARM: mvebu: fix PCIe/mvebu-soc-id issue
In-Reply-To: <20140513151354.GA27822@titan.lakedaemon.net>
References: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140513151354.GA27822@titan.lakedaemon.net>
Message-ID: <20140513171759.66421548@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 13 May 2014 11:13:54 -0400, Jason Cooper wrote:

> Series applied to mvebu/fixes with Gregory's Ack, and Tested-by's from
> Gregory, Andrew, and Willy.
> 
> Also, as Rob noted, if you are going to add 'Fixes' tags, please do so
> in the following format:
> 
>   Fixes: af8d1c63afcb ("ARM: mvebu: Add support to get the ID and the revision of a SoC")

Ok, no problem.

> Note that it uses double quotes, and only 12 characters for the hash.
> 
> Also, the second patch depends on the first, so I've amended the tags as
> such for the second patch:
> 
>   Fixes: af8d1c63afcb ("ARM: mvebu: Add support to get the ID and the revision of a SoC")
>   Cc: <stable@vger.kernel.org> # 3.14+: 42a18d1cf484: ARM: mvebu: mvebu-soc-id: add missing clk_put() call
>   Cc: <stable@vger.kernel.org> # 3.14+

Right.

> Keep in mind, I don't require any of this.  I /ask/ for the commit hash
> of the commit introducing the regression, just to make my job easier.
> If you are going to put it in the Fixes format, great.

Yes, I find it doesn't cost me much time, and can possibly save you a
good amount of time. It also ensures a kind of double checking on these
informations: I write them, and then you verify them while applying the
patch.

> As for the stable tags, you can't very well add the dependency info
> since you don't have the commit hash of the first patch yet. :)

Indeed.

> Thanks for all the effort diagnosing this problem and finding the fix!

You're welcome.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
