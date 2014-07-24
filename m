From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Jul 2014 14:10:25 +0800
Subject: [PATCH] ARM: dts: imx: Add alias for ethernet controller
In-Reply-To: <20140724035253.GA7484@kroah.com>
References: <1406167639-6911-1-git-send-email-marex@denx.de>
 <20140724031753.GA6827@dragon> <20140724035253.GA7484@kroah.com>
Message-ID: <20140724061023.GB6827@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 08:52:53PM -0700, Greg KH wrote:
> On Thu, Jul 24, 2014 at 11:17:55AM +0800, Shawn Guo wrote:
> > On Thu, Jul 24, 2014 at 04:07:19AM +0200, Marek Vasut wrote:
> > > commit 22970070e027cbbb9b2878f8f7c31d0d7f29e94d upstream.
> > > 
> > > Add alias for FEC ethernet on i.MX25, i.MX27, i.MX51 and i.MX53 to allow
> > > bootloaders (like U-Boot) patch-in the MAC address for FEC using this
> > > alias.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: <stable@vger.kernel.org> # 3.14.x
> > 
> > Since the patch is already on mainline, and the submitting target is
> > 3.14.x stable kernel, you should really send it to Greg.
> 
> No, Marek did the right thing here by sending it to the stable at vger
> mailing list, never send stable patches only to me.

Oh, I did not mean sending the patch only to you, but have you on copy.

Shawn
