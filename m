From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 08 Apr 2014 11:40:04 +0200
Subject: [PATCH V2 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <CAK9yfHz_J+NAtxk-Ec-cW6_u0ukssNGi24HZgGRRXb8Hzz2sig@mail.gmail.com>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <CAOesGMgf4owZBCVz4RTgbFVsogws6WKARmA7COkgXVQaG5ky9A@mail.gmail.com>
 <CAK9yfHz_J+NAtxk-Ec-cW6_u0ukssNGi24HZgGRRXb8Hzz2sig@mail.gmail.com>
Message-ID: <1476266.LaBMgo4h3O@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 08, 2014 09:27:04 AM Sachin Kamat wrote:
> On 8 April 2014 00:03, Olof Johansson <olof@lixom.net> wrote:
> > On Mon, Apr 7, 2014 at 10:44 AM, Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com> wrote:
> >>
> >> Hi,
> >>
> >> On Monday, April 07, 2014 09:28:39 AM Olof Johansson wrote:
> >>> On Fri, Apr 4, 2014 at 9:09 AM, Bartlomiej Zolnierkiewicz
> >>> <b.zolnierkie@samsung.com> wrote:
> >>>
> >>> [...]
> >
> > Does 5420 even work upstream? I have hardware access but nothing that
> > will run an upstream kernel as far as I know. Maybe SLSI has an SMDK
> > they can help out with?
> 
> By working upstream if you mean being bootable, then yes I am able to boot both
> SMDK and Arndale Octa boards based on 5420 with the current upstream kernel.
> CPU idle however doesn't work though. I get a crash when I hot plug out all
> secondary CPUs on SMDK.

Thanks for testing.  This behavior is an expected one given the current code
(=> we need to disable AFTR on 5420 for now).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
