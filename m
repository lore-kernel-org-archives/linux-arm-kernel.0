From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Fri, 6 Aug 2010 12:23:45 -0700 (PDT)
Subject: Impossible constraint in 'asm' in 2.6.35 build
In-Reply-To: <217515.74361.qm@web51005.mail.re2.yahoo.com>
Message-ID: <252875.53499.qm@web51004.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Fri, 8/6/10, Fabio Estevam <fabioestevam@yahoo.com> wrote:

> From: Fabio Estevam <fabioestevam@yahoo.com>
> Subject: Re: Impossible constraint in 'asm' in 2.6.35 build
> To: "Rob Herring" <robherring2@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Date: Friday, August 6, 2010, 3:34 PM
> Rob,
> 
> --- On Fri, 8/6/10, Rob Herring <robherring2@gmail.com>
> wrote:
> 
> > From: Rob Herring <robherring2@gmail.com>
> > Subject: Re: Impossible constraint in 'asm' in 2.6.35
> build
> > To: "Fabio Estevam" <fabioestevam@yahoo.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Date: Friday, August 6, 2010, 3:14 PM
> > Fabio,
> > 
> > It is due to this commit and using gcc 4.1.2:
> > 
> > commit 398aa66827155ef52bab58bebd24597d90968929
> > Author: Will Deacon <will.deacon@arm.com>
> > Date:???Thu Jul 8 10:59:16 2010 +0100
> > 
> > ? ? ARM: 6212/1: atomic ops: add memory
> > constraints to inline asm
> > 
> > It works fine for me with CS 4.3.3 toolchain.
> 
> I could get it to build in origin/master branch, but it
> fails for me in Sascha's origin/imx-for-2.6.36 branch.
> 
> Will use origin/master for now.

I made a mistake when upgrading the toolchain. origin/imx-for-2.6.36 branch builds fine now with arm-2010q1 toolchain.

Regards,

Fabio Estevam





      
