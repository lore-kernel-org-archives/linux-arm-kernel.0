From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 23:28:19 +0000
Subject: [PATCH v6 1/3] USB: OHCI-HCD: Rename ohci-pnx4008 to ohci-nxp
In-Reply-To: <1331430375-31227-2-git-send-email-stigge@antcom.de>
References: <1331430375-31227-1-git-send-email-stigge@antcom.de>
 <1331430375-31227-2-git-send-email-stigge@antcom.de>
Message-ID: <20120312232819.GD10830@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 02:46:13AM +0100, Roland Stigge wrote:
> Since this driver is compatible with several NXP devices, the driver is renamed
> accordingly. Please combine with the following patch which also changes the
> respective symbol names.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Please use -C or -M when generating these kinds of patches.  It makes
it possible to see what if anything has changed in the renamed file
(and makes the diff smaller.)

Thanks.
