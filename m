From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Sep 2016 16:53:17 +0100
Subject: [PATCH] musb: Export musb_root_disconnect for use in modules
In-Reply-To: <20160916154701.GA20742@kroah.com>
References: <20160916145936.3297-1-hdegoede@redhat.com>
 <20160916154701.GA20742@kroah.com>
Message-ID: <20160916155317.GE27974@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 05:47:01PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 16, 2016 at 04:59:36PM +0200, Hans de Goede wrote:

> > +EXPORT_SYMBOL_GPL(musb_root_disconnect);

> Does this fix a build error somehow?  Who reported it?

Yes, the sunxi driver uses this symbol and the build bots reported it
yesterday.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160916/1c94a40d/attachment-0001.sig>
