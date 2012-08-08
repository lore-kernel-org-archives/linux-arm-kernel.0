From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Aug 2012 14:09:59 +0100
Subject: [PATCH 1/1 v2] i2c: Add default configuration into the Nomadik
 I2C driver.
In-Reply-To: <CACRpkdZj2LqFF_i6f3M2uzUkhG6og5n2cTzUgqRZA1_NmhWBNA@mail.gmail.com>
References: <1344266253-14050-1-git-send-email-lee.jones@linaro.org>
 <20120806153503.GH10524@gmail.com>
 <CACRpkdZjbyQbht+UpXrrVGhAzGYPjb=HRZhJ+TvsEXhGeviJLA@mail.gmail.com>
 <20120807153112.GF10719@gmail.com>
 <CACRpkdZj2LqFF_i6f3M2uzUkhG6og5n2cTzUgqRZA1_NmhWBNA@mail.gmail.com>
Message-ID: <20120808130958.GC8227@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 02:38:23PM +0200, Linus Walleij wrote:
> On Tue, Aug 7, 2012 at 5:31 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > From: Lee Jones <lee.jones@linaro.org>
> > Date: Tue, 7 Aug 2012 12:27:24 +0100
> > Subject: [PATCH 1/1 v3] i2c: Add default configuration into the Nomadik I2C
> >  driver.
> 
> This has some bad whitespace damage, and the subject should
> be "i2c/nomadik:"

White space damage? You mean the subject line-wrap? 

`git format-patch` does that. I'll change the subject line to i2c/nomadik.

> > Cc: linux-i2c at vger.kernel.org
> > Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Double sign-off.

Hmm... this is fast becoming my nemosis patch!

> Unless Wolfram volunteers to fix this up I suggest you
> fix it nocheinmal und senden einer neues version.

That's okay, it's my error, I'll fix. 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
