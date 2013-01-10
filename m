From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 10 Jan 2013 13:53:47 -0600
Subject: [PATCH 1/7] clk: add common of_clk_init() function
In-Reply-To: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130110195347.GN19380@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 12:30:52PM +0530, Prashant Gaikwad wrote:
> Modify of_clk_init function so that it will determine which
> driver to initialize based on device tree instead of each driver
> registering to it.
> 
> Based on a similar patch for drivers/irqchip by Thomas Petazzoni and
> drivers/clocksource by Stephen Warren.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---

Prashant-

Sorry for the late response, but I finally got a chance to give this
patchset a spin on Zynq.  For patches 1 and 6:

Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
Tested-by: Josh Cartwright <josh.cartwright@ni.com>

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/bf9d75c2/attachment.sig>
