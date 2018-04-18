From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Apr 2018 15:57:08 +0200
Subject: [PATCH 0/3] Add R8A77980/Condor PCIe support
In-Reply-To: <f07e6173-75b3-fe10-81d6-915942a5f4fe@cogentembedded.com>
References: <f07e6173-75b3-fe10-81d6-915942a5f4fe@cogentembedded.com>
Message-ID: <20180418135707.ruifzsv3ljgriujg@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 11:11:38PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
> 'renesas-devel-20180330-v4.16-rc7' tag. We're adding the R8A77980 PCIe related
> device nodes and then enable PCIe on the Condor board. These patches depend on
> the R8A77980 PCIe PHY and PCIEC driver support in order to work properly...

Thanks, I have marked these as deferred.

Please ping me once the dependencies have been accepted.
