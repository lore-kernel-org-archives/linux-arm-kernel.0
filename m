From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 May 2014 09:51:44 +0100
Subject: [PATCH 1/3] perf tests: Introduce perf_regs_load function on ARM64
In-Reply-To: <CAORVsuV5qYKLd21YSJhLy7Ovi5s4sXUEgbNot7LJspNnbdBpFw@mail.gmail.com>
References: <CAFrcx1nfkDWTu9vF+a7UGjd1fzHpXS44pzqKLZS9ej7KJwqkOg@mail.gmail.com>
 <1398690730-5454-1-git-send-email-jean.pihet@linaro.org>
 <CAFrcx1kQO5i+kQwDizT1F4asbFNGiDSDWt0ubnpS92fU1PBiHw@mail.gmail.com>
 <20140502165105.GD20642@arm.com>
 <CAORVsuV5qYKLd21YSJhLy7Ovi5s4sXUEgbNot7LJspNnbdBpFw@mail.gmail.com>
Message-ID: <20140506085144.GA26592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 08:07:11AM +0100, Jean Pihet wrote:
> Hi Will,
> 
> On Fri, May 2, 2014 at 6:51 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, May 02, 2014 at 10:19:38AM +0100, Jean Pihet wrote:
> >> Hi WIll, Mark,
> >>
> >> Ping on this series. Can you please check? Is the refreshed patch OK?
> >
> > Fine by me, as long as it's not reused outside of this test :)
> Great! Is there some precaution to avoid a mis-reuse?

Hopefully your comment will be enough.

> Other than that, which tree are the patches going to?

They're all under perf/tools/, so they should go via that tree.

Will
