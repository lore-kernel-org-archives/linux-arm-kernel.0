From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Oct 2012 18:20:57 +0200
Subject: [PATCH V2 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohpomvCkzSuP1GLBXmDTRCHeKXDgGwwXQ+TzU=Jekmozzo=A@mail.gmail.com>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
 <20121012145027.GF12801@game.jcrosoft.org>
 <CAKohpomvCkzSuP1GLBXmDTRCHeKXDgGwwXQ+TzU=Jekmozzo=A@mail.gmail.com>
Message-ID: <20121012162057.GG12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:25 Fri 12 Oct     , Viresh Kumar wrote:
> On 12 October 2012 20:20, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 20:01 Fri 12 Oct     , Viresh Kumar wrote:
> >> dw_dmac driver already supports device tree but it used to have its platform
> >> data passed the non-DT way.
> >>
> >> This patch does following changes:
> >> - pass platform data via DT, non-DT way still takes precedence if both are used.
> > why keep it  all platform are DT
> 
> I would love to remove that, but not sure if somebody want's the non-DT
> way too.
> 
> I didn't wanted to get into fixing user SoCs of this driver.
no drop it at the mailine if do not need it

Best Regads,
J.
