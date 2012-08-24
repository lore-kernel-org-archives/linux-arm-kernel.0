From: mturquette@ti.com (Mike Turquette)
Date: Fri, 24 Aug 2012 16:51:39 -0700
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <CACRpkdZF-J_P9M2hOZhnJtNrUE_2exefUg1Tj7S_dj0jUPBuKA@mail.gmail.com>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdaDi8KMk0tyWuEHGnLWhZ4ufnNY4cUm-+q9kKryBztzkw@mail.gmail.com>
 <CACRpkdZF-J_P9M2hOZhnJtNrUE_2exefUg1Tj7S_dj0jUPBuKA@mail.gmail.com>
Message-ID: <20120824235139.18366.17586@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-08-22 05:09:30)
> On Thu, Aug 16, 2012 at 2:56 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Aug 6, 2012 at 6:32 PM, Linus Walleij
> > <linus.walleij@stericsson.com> wrote:
> >
> >> This converts the ARM RealView machine over to using the common
> >> clock. The approach is similar to the one used for the Integrator,
> >> and we're reusing the ICST wrapper code.
> >
> > Mike have you had time to look at this? I got Pawel's ACK in the thread.
> 
> Ping again on this, if it's OK it would be great to get some rotation in
> -next for this patch.
> 

Hi Linus,

Apologies for the delayed response.  I've been AWOL on clk patches since
the 3.5 release.

I've taken this into clk-next which will be published (based on 3.6-rc3)
this evening.

Regards,
Mike

> Yours,
> Linus Walleij
