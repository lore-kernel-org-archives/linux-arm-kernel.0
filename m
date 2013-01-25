From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jan 2013 11:15:48 -0800
Subject: [PATCH 5/6] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <3747315.IyCCRDXgbD@flatron>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
 <20130114150531.GE21142@e102568-lin.cambridge.arm.com>
 <20130116105957.GA1963@linaro.org> <3747315.IyCCRDXgbD@flatron>
Message-ID: <016c01cdfb30$64f80430$2ee80c90$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:

[...]

> > Well, the number of CPU types does not grow rapidly.  It will be much
> > less than one per SoC -- so keeping the list up to date shouldn't be
> > that much effort.
> >
> > For ARM1176JZF-S, it could make sense for the comatible list to be
> >
> > 	"arm,arm1176jzf-s", "arm,arm1176"
> >
> > ...since the differences between 1176 variants are software probeable
> > (i.e., whether there is an FPU or not).  AFAIK the J, Z apply to all
> > ARM1176, and the -S (synthesisable RTL) is nothing to do with software.
> > The kernel probably only really needs to know "arm,arm1176".
> 
> OK. So the conclusion is that I should change the cpus node to following:
> 
>        cpus {
>                cpu {

cpu at 0 { ?

>                        compatible = "arm,arm1176jzf-s", "arm,arm1176";
>                };
>        };
> 
> Am I right?
> 
I think so :-)

- Kukjin
