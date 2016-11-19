From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 17:43:27 -0800
Subject: [GIT PULL] Renesas ARM Based SoC EtherAVB Updates for v4.10
In-Reply-To: <cover.1479390880.git.horms+renesas@verge.net.au>
References: <cover.1479390880.git.horms+renesas@verge.net.au>
Message-ID: <20161119014327.GD2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 03:05:08PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC EtherAVB updates for v4.10.
> 
> This pull request is based on the "Second Round of Renesas ARM64 Based SoC
> DT Updates for v4.10", tagged as arm64-dt-for-v4.10, which I have also sent
> a pull-request for.
> 
> The reason for this base is to provide dependencies. For the same reason
> an ack has been provided by David Miller to facilitate a merge of the patch
> via the Renesas tree.

And now we have cascading dependencies. Can't merge this either.

Why is the DT branch and this driver branch entangled?! Again, there is
absolutely no functional dependency between them.


-Olof
