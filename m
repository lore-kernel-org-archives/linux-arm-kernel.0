From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 May 2014 20:20:57 +0100
Subject: [PATCH 3/4] clk: samsung: Add driver to control CLKOUT line on
 Exynos SoCs
In-Reply-To: <537DE714.1090407@samsung.com>
References: <1400604211-9447-1-git-send-email-t.figa@samsung.com>
 <1400604211-9447-4-git-send-email-t.figa@samsung.com>
 <537D8788.8030904@linaro.org> <537DD2C0.4060802@samsung.com>
 <CAHbNUh2gkpV-rt6S+-bUmFvYAuK_HNoXfyOStwYe29sZMJonUw@mail.gmail.com>
 <537DE714.1090407@samsung.com>
Message-ID: <20140522192057.GU12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 02:01:24PM +0200, Tomasz Figa wrote:
> On 22.05.2014 13:44, Tushar Behera wrote:

> > I would be happy to get it done that way. I can see a patch from
> > Sylwester regarding this, but there hasn't been a conclusion as of
> > yet.

> > https://lkml.org/lkml/2014/4/9/173

> Have you mentioned your use case there? It might indicate that this is
> indeed an important problem and that too much bikeshedding doesn't
> really make us closer to the solution.

I've certainly discussed the requirement for this feature with Mike in
person a few times, I don't know if anyone else has been doing anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/69a5b06b/attachment.sig>
