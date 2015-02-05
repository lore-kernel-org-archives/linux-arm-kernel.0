From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 5 Feb 2015 17:11:14 +0200
Subject: [PATCH v3 0/2] couple of generic remoteproc enhancements
In-Reply-To: <54D135C7.4040501@ti.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com>
 <54C17130.5060002@ti.com> <54D135C7.4040501@ti.com>
Message-ID: <CAK=WgbYYi+kojNw=CQ0q3iKEkYE7QxUcinCF400OB9PUSXN-fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Tue, Feb 3, 2015 at 10:55 PM, Suman Anna <s-anna@ti.com> wrote:
> > On 01/09/2015 03:21 PM, Suman Anna wrote:
> >> Hi Ohad,
> >>
> >> The following is an updated patchset addressing the previous pending comments
> >> from v1 & v2, and are rebased onto the latest 3.19-rc3 (are rc independent
> >> actually).
> >>
> >> The patches are mainly developed to support the WkupM3 remote processor driver
> >> on TI AM335x/AM437x SoCs, and I have verified the loading using the latest
> >> version of Dave's WkupM3 remoteproc work [1]
> >>
> >> The only change in v3 is on the second patch, it mainly leverages the
> >> memcpy_toio and memset_io functions for copying/loading code into the
> >> internal memory sections. An additional argument has to be added to the
> >> rproc_da_to_va function to make this distinction.
> >
> > Any comments on this series, or can I assume that this will make it to
> > v3.20?
>
> ping, want to make sure this has not fallen off your radar..

It has not. I'm a bit swamped so apologies for not taking care of this
faster. I believe I'll get to it next week.

Thanks,
Ohad.
