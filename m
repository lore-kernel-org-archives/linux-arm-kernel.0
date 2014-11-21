From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 21 Nov 2014 14:31:07 -0400
Subject: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
In-Reply-To: <20141119164040.GG1875@x1>
References: <1416412231-2752-1-git-send-email-lee.jones@linaro.org>
 <CAOMZO5CwFSRUoVb2j=X=fzaqVN1gUyRki70ewrGrwqLWSHMoAg@mail.gmail.com>
 <20141119164040.GG1875@x1>
Message-ID: <20141121183105.GA10652@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Lee,

On Wed, Nov 19, 2014 at 04:40:40PM +0000, Lee Jones wrote:
> On Wed, 19 Nov 2014, Fabio Estevam wrote:
> 
> > On Wed, Nov 19, 2014 at 1:50 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > > Prevents build warning:
> > >
> > > st_thermal.c:278:12:
> > >     warning: ?st_thermal_suspend? defined but not used [-Wunused-function]
> > > st_thermal.c:286:12:
> > >     warning: ?st_thermal_resume? defined but not used [-Wunused-function]
> > >
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >
> > > v1 => v2:
> > >  - CONFIG_PM => CONFIG_PM_SLEEP suggested by David Paris.
> > 
> > You should also update the Subject to 'when !PM_SLEEP'
> 
> I guess we should, yes.
> 
> Zhang, Eduardo,
> 
> Are you happy to do that, or would you like me to re-spin again?
> 

I can edit the patch for you this time.

Next time, when sending new versions, a couple of advices:
(1) add the Ack's/Reviewed's/Tested's -by  you get along the way.
(2) please, version you patches, it easies maintainter's life while
reviewing / applying your patches.

Thanks for sending the fix.

Eduardo Valentin

> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/0449ed82/attachment.sig>
