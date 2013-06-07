From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 07 Jun 2013 13:16:34 +0200
Subject: [GIT PULL] CPUFreq: ARM Updates for v3.11
In-Reply-To: <CAKohponx-dSdRVX77Fa8ePKhppvvE=dS=ofJT0_+3014b38ZOg@mail.gmail.com>
References: <CAKohpokdrw1KZuCx6Y5E1JyK-Yq0T1fh0qP+bEaqgZjoK8JEEQ@mail.gmail.com>
 <54837539.yBQlA0EhhC@vostro.rjw.lan>
 <CAKohponx-dSdRVX77Fa8ePKhppvvE=dS=ofJT0_+3014b38ZOg@mail.gmail.com>
Message-ID: <4129326.tFXhKE6MIr@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 07, 2013 04:35:24 PM Viresh Kumar wrote:
> On 7 June 2013 16:41, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, June 07, 2013 04:26:36 PM Viresh Kumar wrote:
> 
> >>       cpufreq: bit.LITTLE needs cpufreq table
> >
> > That should be big.LITTLE I suppose?
> 
> Yes. This is not the first time I face this issue where big is
> written as bit. Even I named one of my external repo like this
> earlier and after a long time some other careful viewer caught
> it :)
> 
> Fixed my branch now with s/bit/big.

OK, thanks!

Care to resend the request, since the commit IDs have changed?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
