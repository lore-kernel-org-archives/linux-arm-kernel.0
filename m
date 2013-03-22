From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 22 Mar 2013 12:19:09 -0700
Subject: [PATCH 1/1] clk: Fix incorrect return type in clk.c
In-Reply-To: <CADTbHxrF5M++Y5ku90uN7n6Jx=o80qY+dFX+B_s0udSC06D-PQ@mail.gmail.com>
References: <1363168069-11331-1-git-send-email-sachin.kamat@linaro.org>
 <CADTbHxrF5M++Y5ku90uN7n6Jx=o80qY+dFX+B_s0udSC06D-PQ@mail.gmail.com>
Message-ID: <20130322191909.834.66730@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pankaj Jangra (2013-03-13 10:09:18)
> Hi.
> 
> On Wed, Mar 13, 2013 at 3:17 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > Return type of function clk_propagate_rate_change is a pointer.
> > But 0 was being returned. Change it to NULL.
> > Silences the following warning:
> > drivers/clk/clk.c:977:24: warning: Using plain integer as NULL pointer
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/clk/clk.c |    2 +-
> 
> Looks good to me.
> Reviewed-by: Pankaj Jangra <jangra.pankaj9@gmail.com>
> 

Thanks for the fix.  Taken into clk-next.

Regards,
Mike

> Regards,
> Pankaj Jangra
