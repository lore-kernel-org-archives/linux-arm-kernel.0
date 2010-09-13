From: vince@kyllikki.org (Vincent Sanders)
Date: Mon, 13 Sep 2010 16:56:45 +0100
Subject: [PATCH 9/9] Remove unused usb-a9263 default configuration
In-Reply-To: <20100913152748.GC2138@game.jcrosoft.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-10-git-send-email-vince@kyllikki.org>
	<20100913152748.GC2138@game.jcrosoft.org>
Message-ID: <20100913155645.GF4932@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 05:27:48PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:13 Mon 13 Sep     , Vincent Sanders wrote:
> > From: Vincent Sanders <vince@simtec.co.uk>
> > 
> > The usb-a9263 default configuration has not built throughout the
> > 2.6.36 series (since 2.6.35-git1). The kernel link has failed with
> > 
> > fs/built-in.o: In function `nfs_callback_authenticate':
> > compr_zlib.c:(.text+0x8cf18): undefined reference to `svc_gss_principal'
> > 
> > This configuration appers to be unused by the maintainer so remove it.
> > 
> > Signed-off-by: Vincent Sanders <vince@kyllikki.org>
> can we at least put in Cc the configs Maintainers before drop any of them?

I have stopped running around after people individually, if they
cannot be bothered to check their configurations compile I cannot be
bothered to run around after them individually. 

Been chasing after Maintainers for five years and aside from a few
exceptions I ususally get a negative response, time for a new
tactic. The blunt approach seems to work for Linus so I shall try
that.


-- 
Regards Vincent
http://www.kyllikki.org/
