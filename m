From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 30 Sep 2014 09:38:45 +0530
Subject: [PATCH v7 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CABxcv==E9h_V8_YmcvuxRORg7tbnc9uDT-rwqKJeXb_bNr0xXw@mail.gmail.com>
References: <1408625982-3267-1-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybh-R1GsHF-BRhRYQKkCpQFQSE6Mem=A3kz=H3Bemor9xA@mail.gmail.com>
 <CABxcv=kHwCCYhit20qO1q=Nn3KVj8U=8cpCu=DQRuy+R86N0kQ@mail.gmail.com>
 <CAGm_ybgFfnS=bhz2yWUt_b_95Wg=eDNxadzfy7WF+VNFx+pO6Q@mail.gmail.com>
 <CABxcv==E9h_V8_YmcvuxRORg7tbnc9uDT-rwqKJeXb_bNr0xXw@mail.gmail.com>
Message-ID: <000e01cfdc64$4181a710$c484f530$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier and Vikas,

> Hello Vikas,
> 
> On Mon, Sep 29, 2014 at 2:59 PM, Vikas Sajjan <vikas.sajjan@samsung.com>
> wrote:
> > Hi Javier,
> >
> >
> > On Thu, Sep 25, 2014 at 10:45 PM, Javier Martinez Canillas
> >>
> >> The mentioned patches from the PMU series depend on the patch to
> >> decouple the syscon interface from syscon drivers. The latest version
> >> of that patch is Pankaj's "[PATCH v5] mfd: syscon: Decouple syscon
> >> interface from platform devices" [0].
> >>
> >
> >  Since Arnd has given "Reviewed-by" to Pankaj's MFD syscon patch now,
> > Pankaj can rebase his PMU patchset [1],  so that I can re-spin my 5420
> > S2R patchset on top his PMU patchset.
> >
> 
> Indeed, that would be great. Thanks a lot!
> 

I was waiting for syscon patch to be finalized, now I will rebase my the PMU
patches as almost all issues of syscon has been addressed, and I hope it's now ready
to be taken in.

Thanks,
Pankaj Dubey
> >
> > Regards
> > Vikas Sajjan
> 
> Best regards,
> Javier
