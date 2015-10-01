From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 1 Oct 2015 14:58:52 +0800
Subject: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
In-Reply-To: <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
 <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
Message-ID: <1443682732.1714.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for your help to explain the patch.

On Tue, 2015-09-29 at 18:25 +0800, Daniel Kurtz wrote:
> On Sun, Sep 27, 2015 at 7:25 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> >> But then we at least need a corresponding change to the binding documentation.

I'll send a new patch with changing binding document.

> If the existing bindings are not used anywhere yet (*), it seems like
> unnecessary overhead to enforce backwards compatibility at this stage.
> 
> (*) I don't actually know if this is true, perhaps only Mediatek can
> answer this.

What does the meaning of existing bindings are used anywhere? Do you
mean this binding is used by other SoCs ?

Currently scpsys driver can't be shared between different Mediatek SoCs
because the power domains are different from each other. So I think it
should no need to maintain backward compatibility on scpsys's binding.

> > Apart from that, please send the dtsi part as a seperate patch.

OK.


Best regards,

James
