From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Oct 2014 11:02:21 +0100
Subject: [PATCH v1 1/5] mfd: tps65910: Convert ti, system-power-controller
 DT property to poweroff-source
In-Reply-To: <CABgxDoJSLrAOMMA7=ZGd4F6z7_FkojCdjUNi52wbocZk7yJowQ@mail.gmail.com>
References: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
 <CABgxDoKus_D=ooCz3TqyXP9CTJUgbZVxQSsw4ZgBx1oYaTefbw@mail.gmail.com>
 <20141022155058.GN4939@x1>
 <CABgxDoJSLrAOMMA7=ZGd4F6z7_FkojCdjUNi52wbocZk7yJowQ@mail.gmail.com>
Message-ID: <20141023100221.GA10395@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Oct 2014, PERIER Romain wrote:

> 2014-10-22 17:50 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
> > On Wed, 22 Oct 2014, PERIER Romain wrote:
> >
> >> This is related to the following subject "[RFC v3 PATCH 1/5] of: Add
> >> standard property for poweroff capability" and depends on the
> >> corresponding patch.
> >
> > Then it should be sent in the same patch-set.
> >
> > There's nothing I can do with this patch as is.
> >
> 
> Even if this patch is already commited and present in "linux-next" ?
> (or in Mark Brown's regulator tree)

Usually it wouldn't be possible to take this, as it would be
difficult to ensure bisectability.  The way we usually deal with this
is to have a shared immutable branch between the effected subsystems,
but we can only do this if the patches are sent as a set.  However, it
appears as though Mark has "of: Add standard property for poweroff
capability" on a tagged branch on its own.  This means, after checking
with Mark that this branch in indeed stable, I can merge it in and
base this commit on top of it.  Not many people setup their repos like
Mark does, so I guess you are lucky this time.

Once I've heard back from Mark, I'll let you know when I apply the
patch.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
