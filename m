From: gregkh@suse.de (Greg KH)
Date: Thu, 4 Mar 2010 15:56:50 -0800
Subject: [PATCH 2.6.34] USB: Fix s3c-hsotg build following Samsung
	platform header moves
In-Reply-To: <4B903B5A.3070204@simtec.co.uk>
References: <1267469502-19560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4B903B5A.3070204@simtec.co.uk>
Message-ID: <20100304235612.GA11805@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 04, 2010 at 10:59:38PM +0000, Ben Dooks wrote:
> Mark Brown wrote:
> >Fix a reference to regs-sys.h got missed in the reorganisation of
> >the Samsung platform headers targetted for 2.6.34.
> >
> >Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> anyone mind if this gets merged into my next tree and given to RMK?

No objection from me, feel free to add a:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to it and push it through your tree.

thanks,

greg k-h
