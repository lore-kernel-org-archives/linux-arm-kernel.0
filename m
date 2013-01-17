From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Jan 2013 13:39:21 +0000
Subject: [PATCH] ARM: ux500: Include the PRCMU's Secure Registers in
 DB8500's DT
In-Reply-To: <CACRpkdZhRESXHNVFPzUx7H0ppZ+KSfPOJ2bPS+-CQyv6+8=oZQ@mail.gmail.com>
References: <1357901029-9073-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZhRESXHNVFPzUx7H0ppZ+KSfPOJ2bPS+-CQyv6+8=oZQ@mail.gmail.com>
Message-ID: <20130117133921.GQ20091@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Jan 2013, Linus Walleij wrote:

> On Fri, Jan 11, 2013 at 11:43 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Currently we only include the PRCMU's primary registers when
> > referencing the register count in the 'reg' property. This patch
> > expands that count to include the secure registers also.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Will you push this to ARM SoC or shall I queue it?

I'll take it.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
