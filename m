From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Jun 2013 16:35:24 +0530
Subject: [GIT PULL] CPUFreq: ARM Updates for v3.11
In-Reply-To: <54837539.yBQlA0EhhC@vostro.rjw.lan>
References: <CAKohpokdrw1KZuCx6Y5E1JyK-Yq0T1fh0qP+bEaqgZjoK8JEEQ@mail.gmail.com>
 <54837539.yBQlA0EhhC@vostro.rjw.lan>
Message-ID: <CAKohponx-dSdRVX77Fa8ePKhppvvE=dS=ofJT0_+3014b38ZOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2013 16:41, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, June 07, 2013 04:26:36 PM Viresh Kumar wrote:

>>       cpufreq: bit.LITTLE needs cpufreq table
>
> That should be big.LITTLE I suppose?

Yes. This is not the first time I face this issue where big is
written as bit. Even I named one of my external repo like this
earlier and after a long time some other careful viewer caught
it :)

Fixed my branch now with s/bit/big.

Thanks.
