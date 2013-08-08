From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 08 Aug 2013 08:32:16 +0200
Subject: [PATCH] [TRIVIAL] ARM: msm: fix compilation error in gpiomux
In-Reply-To: <20130807210804.GB14845@codeaurora.org>
References: <1375857279-18082-1-git-send-email-k.kozlowski@samsung.com>
 <20130807174053.GA17551@codeaurora.org>
 <20130807210804.GB14845@codeaurora.org>
Message-ID: <1375943536.30982.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2013-08-07 at 14:08 -0700, Stephen Boyd wrote:
> On 08/07, David Brown wrote:
> > On Wed, Aug 07, 2013 at 08:34:39AM +0200, Krzysztof Kozlowski wrote:
> > >Fix compilation error in gpiomux (CONFIG_MSM_GPIOMUX=y):
> > >arch/arm/mach-msm/gpiomux.c:24:13: error: static declaration of
> > >	???__msm_gpiomux_write??? follows non-static declaration
> > >arch/arm/mach-msm/gpiomux.h:85:6: note: previous declaration of
> > >	???__msm_gpiomux_write??? was here
> > >
> > >Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > 
> > Thanks, I'll pull this in.
> > 
> >  <https://patchwork.kernel.org/patch/2839921/>
> > 
> 
> I believe this is fixed by Rohit's patch that has already been
> taken in a pull request?
> 
> https://lkml.org/lkml/2013/7/26/608

Yes, Rohit's patch fixes the problem so this is already in linux-msm
tree.


Best regards,
Krzysztof
