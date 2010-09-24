From: jhnikula@gmail.com (Jarkko Nikula)
Date: Fri, 24 Sep 2010 08:53:37 +0300
Subject: [PATCH 00/11] omap patches for review for v2.6.37 merge window
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Message-ID: <20100924085337.69c99bd8.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Sep 2010 18:50:38 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Hi all,
> 
> Here are some omap patches that have not yet been posted to
> linux-arm-kernel for review.
> 
> Jarkko Nikula (4):
>       omap: n8x0: Cleanup i2c1 and menelaus registration
>       omap: n8x0: Register i2c2 and add board info with tlv320aic3xfor N810
>       omap: n8x0: Mux i2s codec port pins for McBSP block
>       omap2: McBSP: Remove mux code for OMAP2420 McBSP2 and docleanups
> 
...
> Subramaniam C.A (1):
>       omap: i2c: Avoid compilation error in case the header is included multiple times
> 
Hmm... I wonder do I have something wrong or in patchwork but it looks
like somehow a line feed gets introduced to subject line of some of
my patches. And it seems to do with my patches only.

Original patch in my mailbox or archive doesn't show it but it is in
patchwork.

http://marc.info/?l=linux-omap&m=128324955316265&w=2
https://patchwork.kernel.org/patch/144841/mbox


-- 
Jarkko
