From: mporter@linaro.org (Matt Porter)
Date: Tue, 11 Mar 2014 20:57:48 -0400
Subject: [PATCH v3 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <20140312004030.GH28112@sirena.org.uk>
References: <1394552775-31264-1-git-send-email-mporter@linaro.org>
 <1394552775-31264-3-git-send-email-mporter@linaro.org>
 <20140311160837.GP21216@lee--X1> <20140311221938.GO25092@beef>
 <20140311224517.GA5672@lee--X1> <20140311232545.GP25092@beef>
 <20140312004030.GH28112@sirena.org.uk>
Message-ID: <20140312005748.GQ25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 12:40:30AM +0000, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 07:25:45PM -0400, Matt Porter wrote:
> > On Tue, Mar 11, 2014 at 10:45:17PM +0000, Lee Jones wrote:
> 
> > > Are there any inter-patch dependencies in the set? If so, we should
> > > know about them so we can coordinate a sensible solution.
> 
> > Yes, the regulator driver (3/5) that Mark applied is dependent on this
> > patch...the regulator driver includes include/linux/mfd/bcm590xx.h.
> 
> There's no actual dependency though - the regulator driver can only be
> built if the MFD is enabled in Kconfig since it depends on it so until
> the MFD is present in the tree it won't get built.

Oh, right. Lee, no dependencies then.

-Matt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/0d0fa461/attachment-0001.sig>
