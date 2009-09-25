From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 25 Sep 2009 15:50:19 -0400 (EDT)
Subject: arm: current mainline fails to boot on QNAP TS-109
In-Reply-To: <200909252039.19789.elendil@planet.nl>
References: <200909252039.19789.elendil@planet.nl>
Message-ID: <alpine.LFD.2.00.0909251547450.4997@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Sep 2009, Frans Pop wrote:

> Current mainline kernel fails to boot on my QNAP TS-109 (orion5x).
> 
> It fails immediately after uncompressing the kernel, there are no other 
> messages on the serial console. The problem was probably introduced in the 
> last ARM merge:
> 
> v2.6.31-8766-gf25f60b is OK
> v2.6.31-8936-g851b147 fails
> 
> If needed I can run a bisect between those commits.

No need -- I found the screw-up.  Will submit a patch right away.

In the mean time just revert commit 200b812d00.


Nicolas
