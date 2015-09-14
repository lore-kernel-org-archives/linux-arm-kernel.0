From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 14 Sep 2015 12:07:58 +0100
Subject: [PATCH v2] arm/xen: Enable user access to the kernel before
 issuing a privcmd call
In-Reply-To: <20150914100420.GG21084@n2100.arm.linux.org.uk>
References: <1441988759-4572-1-git-send-email-julien.grall@citrix.com>
 <20150911170027.GX21084@n2100.arm.linux.org.uk> <55F3102B.3090309@citrix.com>
 <55F31105.6070305@citrix.com> <20150911175107.GY21084@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1509111856020.2672@kaball.uk.xensource.com>
 <20150911175951.GA21084@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1509141036430.2672@kaball.uk.xensource.com>
 <20150914100420.GG21084@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1509141207460.2672@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Sep 2015, Russell King - ARM Linux wrote:
> On Mon, Sep 14, 2015 at 10:36:55AM +0100, Stefano Stabellini wrote:
> > On Fri, 11 Sep 2015, Russell King - ARM Linux wrote:
> > > If you'd like your ack on it, please send one, I can still do that.
> > 
> > Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> Sorry, that's a bit too late - I sent Linus the pull request on Saturday,
> but it missed the -rc1 release... still waiting for Linus to pull it.

No worries, thanks for letting me know.
