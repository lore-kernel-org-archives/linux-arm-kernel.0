From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 28 Apr 2017 14:23:32 +0200
Subject: [PATCH v3 1/9] bus: fsl-mc: add DPCON object APIs
In-Reply-To: <20170428095034.8842-2-ruxandra.radulescu@nxp.com>
References: <20170428095034.8842-1-ruxandra.radulescu@nxp.com>
 <20170428095034.8842-2-ruxandra.radulescu@nxp.com>
Message-ID: <20170428122332.GB18081@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 04:50:26AM -0500, Ioana Radulescu wrote:
> From: Ioana Radulescu <ruxandra.radulescu@freescale.com>
> 
> This patch adds the command building/parsing wrapper functions
> for the DPCON object. The binary interface version is v3.2.

The subject should have "staging: fsl-mc: bus: ..." to match the other
ones (and to catch my filters properly...)

I'll take this as-is for now.

thanks,

greg k-h
