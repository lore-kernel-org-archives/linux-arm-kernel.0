From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 19 Mar 2012 12:46:53 -0700
Subject: [PATCH] ARM: iop: add missing includes
In-Reply-To: <20120319194016.GA708@ultra.musicnaut.iki.fi>
References: <1329344682-29962-1-git-send-email-olof@lixom.net>
 <20120319194016.GA708@ultra.musicnaut.iki.fi>
Message-ID: <20120319194653.GA9308@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 09:40:16PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Feb 15, 2012 at 02:24:42PM -0800, Olof Johansson wrote:
> > Resolves two build breaks. One is a boatload of "unknown type name 'u32'"
> > in iop3xx.h due to missing include of <linux/types.h>.
> > 
> > The other is:
> > arch/arm/plat-iop/restart.c: In function 'iop3xx_restart':
> > arch/arm/plat-iop/restart.c:18:2: error: implicit declaration of function 'soft_restart' [-Werror=implicit-function-declaration]
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Any chance to get this patch into 3.3.1 (stable), when and if such is made?
> 
> The v3.3 fails to build for IOP boards without this.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
