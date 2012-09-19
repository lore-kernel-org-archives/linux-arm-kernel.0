From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 19 Sep 2012 10:11:26 -0700
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <CACRpkdbntZ2k+2mi7=nCL2RV+YcbYi=wbK2RaDKsKNKqsCxMOA@mail.gmail.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdaKa=NAObnjJyifhxyqu3Hcgj7Fxqi=bdNFqbm7V_8cSw@mail.gmail.com>
 <20120914080347.GB3374@gmail.com>
 <CACRpkdbntZ2k+2mi7=nCL2RV+YcbYi=wbK2RaDKsKNKqsCxMOA@mail.gmail.com>
Message-ID: <20120919171126.GA16730@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 01:22:06PM +0200, Linus Walleij wrote:
> On Fri, Sep 14, 2012 at 10:03 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, Sep 13, 2012 at 11:35:43AM +0200, Linus Walleij wrote:
> >>
> >> Not having this patch in v3.6-rcN gives the following boot noise (and
> >> the key does not work):
> >>
> >> ------------[ cut here ]------------
> >> WARNING: at /home/elinwal/linux-stericsson/kernel/irq/irqdomain.c:137
> >> irq_domain_legacy_revmap+0x20/0x48()
> (...)
> > I haven't tested this, but I think this patch should be pulled out
> > of -next and pushed into the -rcs to fix the issue you see above.
> > The real fix along with the revert to this patch also resides in
> > -next and will be applied during the next merge window.
> 
> Dmitry, can you fix this?
> 
> v3.6-rc6 is regressing on us...

OK, I'll revert and send a pull request tonight.

Thanks.

-- 
Dmitry
