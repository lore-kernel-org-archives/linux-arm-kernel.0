From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 17:38:43 +0200
Subject: [PATCH -next v2] dmaengine: ste_dma40: fix error return code in
 d40_probe()
In-Reply-To: <20130617135028.GE10671@intel.com>
References: <CAPgLHd-gjJ6ju3HyhiQi98YFGojvU3aYSTn7SOe4NhQPY1r++w@mail.gmail.com>
 <CACRpkdYBfvr0kA7bd-6Ns78UH7JtBCFDzFxyHLgtReB32O4D+w@mail.gmail.com>
 <20130530173326.GD3767@intel.com>
 <CACRpkdZhK6TUAC132vzcaLKqdMTwPma+ZhKG5Y+AUvekNpz6EQ@mail.gmail.com>
 <20130612095443.GU4107@intel.com>
 <CACRpkdYS8MYEBs_kcGyOPvcenBALxAXtksRA=+TmkeyOZW=Xzg@mail.gmail.com>
 <20130617135028.GE10671@intel.com>
Message-ID: <CACRpkdYf3cx=-+nZJGCxGJs5TbBAkLwtfaYXWErzn-wnxeFLuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 3:50 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Jun 13, 2013 at 09:49:04AM +0200, Linus Walleij wrote:

>> I haven't sent this patch to ARM SoC so it will not appear from any other source
>> in the merge window or cause any conflicts.
>
> Doesnt apply on my next or -rc6. I think it has some ste dependecies. So either
> we wait and I send this for next -rc2 or you apply with my Ack

I have it queued in my tree so it won't be forgotten.

That said: ARM SoC folks: can you apply this fix directly
to wherever in the ARM SoC tree the DMA40 patches have
ended up? (Looks like next/drivers)

Yours,
Linus Walleij
