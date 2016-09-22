From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Sep 2016 18:40:43 +0100
Subject: [PATCH v2] musb: Export musb_root_disconnect for use in modules
In-Reply-To: <20160922172842.GA23726@kroah.com>
References: <20160917100810.2406-1-hdegoede@redhat.com>
 <20160921205133.GC3981@uda0271908>
 <20160922133016.GE3970@uda0271908>
 <20160922171526.GR7994@sirena.org.uk>
 <20160922172842.GA23726@kroah.com>
Message-ID: <20160922174043.GS7994@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 07:28:42PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 22, 2016 at 06:15:26PM +0100, Mark Brown wrote:
> > On Thu, Sep 22, 2016 at 08:30:16AM -0500, Bin Liu wrote:

> > > Removed it from my tree, since Greg already picked it.

> > It's not showing in today's -next...

> It probably missed the cut-off, should be there tomorrow.

Ah, excellent thanks!  Down to only one build break in all*config in -next :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/10a502e1/attachment.sig>
