From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jul 2016 11:15:53 +0100
Subject: [PATCH v8 0/4] perf: Add APM X-Gene SoC Performance Monitoring
 Unit driver
In-Reply-To: <CADaLNDnqs+jRTfQTXV5VaKbWbQ4dZMGGQAgWXVqWhX8AZZrWgw@mail.gmail.com>
References: <1468263944-10634-1-git-send-email-ttnguyen@apm.com>
 <20160714131602.GJ29455@arm.com>
 <CACgAJHyBt4TCoDjm0XGyX8usD_Wt_-7_JA918Wr4oF567wY_EA@mail.gmail.com>
 <CADaLNDnNVC48Ce1A+KU2WMULkY+skKVSm1GpaoQ6HvAEmscD=A@mail.gmail.com>
 <CADaLNDnqs+jRTfQTXV5VaKbWbQ4dZMGGQAgWXVqWhX8AZZrWgw@mail.gmail.com>
Message-ID: <20160720101553.GA20508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 01:22:09PM -0700, Duc Dang wrote:
> On Thu, Jul 14, 2016 at 10:37 AM, Duc Dang <dhdang@apm.com> wrote:
> > On Thu, Jul 14, 2016 at 10:28 AM, Tai Tri Nguyen <ttnguyen@apm.com> wrote:
> >> On Thu, Jul 14, 2016 at 6:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Mon, Jul 11, 2016 at 12:05:40PM -0700, Tai Nguyen wrote:
> >> >> In addition to the X-Gene ARM CPU performance monitoring unit (PMU), there
> >> >> are PMU for the SoC system devices such as L3 cache(s), I/O bridge(s),
> >> >> memory controller bridges and memory. These PMU devices are loosely
> >> >> architected to follow the same model as the PMU for ARM cores.
> >> >
> >> > You might want to add commit messages to patches 1,2 and 4, but then you
> >> > can route this via the arm-soc tree.
> >> >
> >> > Will
> >>
> >> I will add the commit messages to these patches 1, 2 and 4 and rout
> >> this via arm-soc tree.
> >> CC: Duc (dhdang at apm.com)
> >
> > I will pull patch 1, 2 and 4 into xgene-next tree and send pull
> > request to Arnd and Olof.
> 
> Hi Will,
> 
> Do you plan to merge this series (Tai posted v10) into 4.8 or you want
> to wait until 4.9? Please let know so that I can plan my pull request
> to Arnd/Olof accordingly to include patch 1, 2, and 4.

I was hoping that the whole series would go via arm-soc. Mark reviewed
the PMU driver code, so that should be sufficient.

Will
