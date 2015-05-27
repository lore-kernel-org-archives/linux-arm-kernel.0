From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 27 May 2015 18:46:47 +0200
Subject: [PATCH v4 2/2] soc: Add driver for Freescale Vybrid Platform
In-Reply-To: <20150527130727.GA3374@Sanchayan-Arch.toradex.int>
References: <cover.1432637313.git.maitysanchayan@gmail.com>
 <7df753efff77a96da285f0571f1316512787e83c.1432637313.git.maitysanchayan@gmail.com>
 <1432711910.27695.223.camel@x220>
 <20150527130727.GA3374@Sanchayan-Arch.toradex.int>
Message-ID: <1432745207.27695.282.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-27 at 18:37 +0530, maitysanchayan at gmail.com wrote:
> > > +module_platform_driver(vf610_soc_driver);
> > 
> > (The series starting at https://lkml.org/lkml/2015/5/10/131 would allow
> > to use builtin_platform_driver() for built-in only code.)
> 
> Thanks for bringing this to my attention. I am subscribed to the mailing
> list however this skipped me.

> However that series has not been merged yet, so I can't use builtin_*
> yet?

Correct.

If that series get merged, which is not certain at all, you might
consider changing this. Probably no one will notice if you don't.


Paul Bolle
