From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 17:55:54 +0900
Subject: [PATCH/RFC] ARM: shmobile: Enable PM_RUNTIME in defconfig
In-Reply-To: <CAMuHMdVG0=JG+d=_B9XM2OWn157UG4=2gsg2mfuRNwJ7N3qZFw@mail.gmail.com>
References: <1400198682-7666-1-git-send-email-horms+renesas@verge.net.au>
 <20140516020549.GB18137@verge.net.au>
 <CAMuHMdVEowWbMY+L1TuC4xxYvtGZiH5qYOjmd7-rt1e_=xEz1A@mail.gmail.com>
 <20140516080825.GA23295@verge.net.au>
 <CAMuHMdVG0=JG+d=_B9XM2OWn157UG4=2gsg2mfuRNwJ7N3qZFw@mail.gmail.com>
Message-ID: <20140516085553.GC20299@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:39:46AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, May 16, 2014 at 10:08 AM, Simon Horman <horms@verge.net.au> wrote:
> > With that in mind I'll rephrase my question: are you are ware
> > of any patches this one (the defconfig update) should depend on?
> 
> No, I don't think it will introduce any regressions.
> We had CONFIG_PM_RUNTIME in most other defconfigs, and I've been
> running quite some real multi-platform kernels on Koelsch before.
> 
> All known clock issues, for which patches have been send/accepted, happen
> regardless of the value of CONFIG_PM_RUNTIME.

Thanks, I'll queue this up.
