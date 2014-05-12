From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 13 May 2014 00:57:31 +0200
Subject: [PATCH v2.1 3/9] ARM: S3C24XX: enable usage of common dclk if
 common clock framework is enabled
In-Reply-To: <53714F9D.3010109@samsung.com>
References: <2104342.rkElQpXtvM@phil> <3874492.Rok1zBObEC@phil>
 <53714F9D.3010109@samsung.com>
Message-ID: <233328610.kl5NEOjUm6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Am Dienstag, 13. Mai 2014, 07:47:57 schrieb Kukjin Kim:
> On 05/10/14 08:33, Heiko St?bner wrote:
> > Hi Tomasz,
> > 
> >>>>> It seems this one just hit linux-next (in next-20140509).
> >>>> 
> >>>> Which is bad, because:
> >>>> a) it conflicts with patches already applied in samsung-clk tree,
> >>> 
> >>> I remember seeing patches regarding more than one clk-samsung clock
> >>> providers. Do you need any additional changes for s3c24xx from me for
> >>> this?
> >> 
> >> Yes, that's the problem here. If you could do it, I would appreciate it,
> >> but if you don't have time then I can handle this. The changes needed
> >> are mostly trivial - basically every common samsung_clk function gets
> >> new argument to a context structure. The branch to base on would be
> >> for_3.16/exynos5260 in samsung-clk tree.
> 
> I think, would be better if we could fix the conflicts with Hekio's
> additional patches...basically nobody wants revert something for next
> tree once it is landed. But in this case, it's up to Tomasz...
> 
> Probably, Heiko resubmitted? Is it based on the branch Tomasz memtioned,
> I didn't check it yet?..
> 
> Tomasz, do you still want me to drop this series in samsung tree now?
> Additional patches would be helpful to me because other dependency i.e.,
> exynos5260...for me.

I submitted a v3 series yesterday, that is based on Tomasz' branch. This 
prevents build errors from happening. I'll let you two decide how you want to 
handle this :-)

I can also produce fixup patches if you two decide to keep the v2 series and 
just fix the conflicts.


Heiko
