From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 18 Mar 2015 22:42:16 +0530
Subject: pl330 endian fix and two fixups
In-Reply-To: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150318171216.GR32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 11:52:42AM +0000, Ben Dooks wrote:
> When getting the pl330 driver to work on an Xilinx Zynq working in
> big-endian the first patch is needed to get the dmatest suite to
> pass.
> 
> The second and third patches are warning fixes from sparse, of
> which the third may not be the complete solution. It works for me.

Applied, thanks

-- 
~Vinod
