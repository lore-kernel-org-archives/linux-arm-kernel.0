From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 18 May 2012 08:44:46 +1000
Subject: [PATCH] ARM: at91: Add ADC driver to at91sam9260/at91sam9g20
 dtsi files
In-Reply-To: <20120517150601.GA28104@kroah.com>
References: <4FB3B1F3.6080102@atmel.com>
 <1337182626-13033-1-git-send-email-nicolas.ferre@atmel.com>
 <201205161850.54765.arnd@arndb.de>
 <20120517150601.GA28104@kroah.com>
Message-ID: <20120518084446.a7b229074ea215fd7bcd1eb8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Thu, 17 May 2012 08:06:01 -0700 Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 16, 2012 at 06:50:54PM +0000, Arnd Bergmann wrote:
> > On Wednesday 16 May 2012, Nicolas Ferre wrote:
> > > Now that the bulk of at91sam9g20-related nodes are located in at91sam9260.dtsi,
> > > we have to re-create the path to this ADC node for SoC specific parts.
> > > 
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Should we apply this patch in arm-soc so that Greg can drop the hunk that
> > no longer applies?
> 
> It's not a "no longer applies", it's a "this does not merge".  The patch
> is in my tree, unless you want me to revert it, it's going to stay there
> until it goes to Linus.

Just apply the patch to the arm-soc tree - then the merge resolution
becomes "use the arm-soc version".   There is no need for Greg to revert
the other patch.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120518/210f51f5/attachment.sig>
