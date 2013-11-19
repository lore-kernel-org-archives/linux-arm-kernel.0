From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Nov 2013 08:24:10 +0000
Subject: [patch] mfd: ab8500-debugfs: move dereference after check for NULL
In-Reply-To: <CACRpkdZ3GbUCkK3mte3wM_WCmtuvOvCYfu2PkJSy+7yhx_qpqQ@mail.gmail.com>
References: <20131113074030.GA25541@elgon.mountain>
 <CACRpkdZ3GbUCkK3mte3wM_WCmtuvOvCYfu2PkJSy+7yhx_qpqQ@mail.gmail.com>
Message-ID: <20131119082410.GV13640@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013, Linus Walleij wrote:

> On Wed, Nov 13, 2013 at 8:40 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > We dereference "desc" before check if it is NULL.  I've shifted it
> > around so we check first before dereferencing.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > I am not able to compile this.
> 
> Looks and compiles good.
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Lee are you queueing this?

This one slipped through the net, thanks for bringing it to my attention.

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
