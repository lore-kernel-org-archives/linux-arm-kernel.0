From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Jun 2013 19:20:28 +0530
Subject: [PATCH -next v2] dmaengine: ste_dma40: fix error return code
 in d40_probe()
In-Reply-To: <CACRpkdYS8MYEBs_kcGyOPvcenBALxAXtksRA=+TmkeyOZW=Xzg@mail.gmail.com>
References: <CAPgLHd-gjJ6ju3HyhiQi98YFGojvU3aYSTn7SOe4NhQPY1r++w@mail.gmail.com>
 <CACRpkdYBfvr0kA7bd-6Ns78UH7JtBCFDzFxyHLgtReB32O4D+w@mail.gmail.com>
 <20130530173326.GD3767@intel.com>
 <CACRpkdZhK6TUAC132vzcaLKqdMTwPma+ZhKG5Y+AUvekNpz6EQ@mail.gmail.com>
 <20130612095443.GU4107@intel.com>
 <CACRpkdYS8MYEBs_kcGyOPvcenBALxAXtksRA=+TmkeyOZW=Xzg@mail.gmail.com>
Message-ID: <20130617135028.GE10671@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 09:49:04AM +0200, Linus Walleij wrote:
> On Wed, Jun 12, 2013 at 11:54 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> 
> >> Let me know how you want it, I've removed it from my
> >> dma40 branch for the time being.
> >
> > Have you removed, Also I see a v3 of this, do you want to ack that before I
> > apply
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I haven't sent this patch to ARM SoC so it will not appear from any other source
> in the merge window or cause any conflicts.
Doesnt apply on my next or -rc6. I think it has some ste dependecies. So either
we wait and I send this for next -rc2 or you apply with my Ack

--
~Vinod
