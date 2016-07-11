From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 14:03:32 -0700
Subject: [PATCH 1/2] tty: amba-pl011: add support for clock frequency
 setting via dt
In-Reply-To: <CAPPM39Zy2ii4-9ABTr+WtN5zdBjTFomQjzJfdSfrvYC9vhqd1w@mail.gmail.com>
References: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <146799807004.73491.2602277598493203375@resonance>
 <57801DA6.5010506@linaro.org>
 <146802378337.73491.10770797315435166004@resonance>
 <57804897.1080101@codeaurora.org> <57809CD6.2090004@linaro.org>
 <CAPPM39Zy2ii4-9ABTr+WtN5zdBjTFomQjzJfdSfrvYC9vhqd1w@mail.gmail.com>
Message-ID: <20160711210332.GA16764@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, Jorge Ramirez Ortiz wrote:
> On 9 July 2016 at 08:42, Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
> > um, I retested again this morning and it is all good - I was also a bit
> > surprised when things failed yesterday  (it seems one of the wires on my
> > board was loose, sorry).
> >
> > So AFAIC your patch addresses the issue in a much generic (better) way and
> > there are no regressions on a HiKey board running a 4.4 kernel.
> >
> >
> >
> 
> Stephen, will you post your patch again? how do we progress the change set
> (ie your patch & the hikey device tree change)?

Yes I'll post it again today and put it in Russell's patch
tracker soon after that. I assume there isn't any concern with
the patch and it works for you so it would be good to have your
Tested-by too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
