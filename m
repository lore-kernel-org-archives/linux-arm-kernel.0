From: johan@kernel.org (Johan Hovold)
Date: Mon, 24 Jul 2017 15:01:59 +0200
Subject: [PATCH 0/2] ARM: add missing includes to header files
In-Reply-To: <20170706151607.GC23750@n2100.armlinux.org.uk>
References: <20170704132542.27644-1-johan@kernel.org>
 <20170706151607.GC23750@n2100.armlinux.org.uk>
Message-ID: <20170724130159.GI2729@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 04:16:07PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 04, 2017 at 03:25:40PM +0200, Johan Hovold wrote:
> > Add two missing include directives to two header files to avoid
> > compile breakage when the required symbols have not already been
> > defined.
> > 
> > The missing SCU include broke compilation of the (not-yet-merged)
> > suspend support for am335x when !CONFIG_HAVE_ARM_SCU for example:
> > 
> > 	https://lkml.kernel.org/r/20170704131441.GH27842 at localhost
> 
> These look reasonable, please send them to the patch system for merging
> after this merge window, thanks.

These two are now in your patch tracker (since a week).

Thanks,
Johan
