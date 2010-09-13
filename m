From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 13 Sep 2010 17:27:48 +0200
Subject: [PATCH 9/9] Remove unused usb-a9263 default configuration
In-Reply-To: <1284390832-7181-10-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-10-git-send-email-vince@kyllikki.org>
Message-ID: <20100913152748.GC2138@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:13 Mon 13 Sep     , Vincent Sanders wrote:
> From: Vincent Sanders <vince@simtec.co.uk>
> 
> The usb-a9263 default configuration has not built throughout the
> 2.6.36 series (since 2.6.35-git1). The kernel link has failed with
> 
> fs/built-in.o: In function `nfs_callback_authenticate':
> compr_zlib.c:(.text+0x8cf18): undefined reference to `svc_gss_principal'
> 
> This configuration appers to be unused by the maintainer so remove it.
> 
> Signed-off-by: Vincent Sanders <vince@kyllikki.org>
can we at least put in Cc the configs Maintainers before drop any of them?

Best Regards,
J.
