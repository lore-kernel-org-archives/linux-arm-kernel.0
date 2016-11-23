From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Nov 2016 17:06:37 -0600
Subject: [PATCH 4/6] dt-bindings: change hi6220-reset.txt according to
 reset-hi6220.c
In-Reply-To: <2314383.qiZ3Cq7QsP@wuerfel>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <1479800961-6249-5-git-send-email-zhangfei.gao@linaro.org>
 <2314383.qiZ3Cq7QsP@wuerfel>
Message-ID: <20161123230637.m4cvc2l4huxlf5dd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 09:48:32AM +0100, Arnd Bergmann wrote:
> On Tuesday, November 22, 2016 3:49:19 PM CET Zhangfei Gao wrote:
> >  Required properties:
> >  - compatible: should be one of the following:
> > -  - "hisilicon,hi6220-sysctrl", "syscon" : For peripheral reset controller.
> > -  - "hisilicon,hi6220-mediactrl", "syscon" : For media reset controller.
> > -- reg: should be register base and length as documented in the
> > -  datasheet
> > +  - "hisilicon,hi6220-reset-sysctrl" : For peripheral reset controller.
> > +  - "hisilicon,hi6220-reset-mediactrl" : For media reset controller.
> > +- hisi,rst-syscon: phandle of the reset's syscon.
> >  - #reset-cells: 1, see below
> > 
> 
> Please keep the old strings around for compatibility.

Why are these even changing? The commit message should say why.

Rob
