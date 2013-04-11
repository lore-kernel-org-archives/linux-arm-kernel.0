From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 13:14:33 -0400
Subject: [PATCHv2 02/10] bus: mvebu: fix mistake in PCIe window target
 attribute for Kirkwood
In-Reply-To: <1365632436-25367-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365632436-25367-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365632436-25367-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130411171433.GJ28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 12:20:28AM +0200, Thomas Petazzoni wrote:
> The target and attributes for the PCIe address decoding windows were
> not correct on Kirkwood for the second PCIe interface.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Note: this patch should be merged with the existing mvebu-mbus driver.
> ---
>  drivers/bus/mvebu-mbus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/drivers

thx,

Jason.
