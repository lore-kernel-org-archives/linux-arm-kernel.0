From: keescook@chromium.org (Kees Cook)
Date: Thu, 11 May 2017 08:30:28 -0700
Subject: arch: arm: bpf: Converting cBPF to eBPF for arm 32 bit
In-Reply-To: <CAHgaXdLJoVUXXGTYs7FYXay5wx=sA-O+=dYhX+r7AQT7vSNfGQ@mail.gmail.com>
References: <CAHgaXdKsO2xoKYp7g91g+n+d_1KHSSByLjzBB-WjVXSjhB7qxw@mail.gmail.com>
 <20170510.212952.1440495072777358778.davem@davemloft.net>
 <CAHgaXdK8LEEUPm4jTRRzCnjwdWAauHmmB=caZsSFY8MmStH89Q@mail.gmail.com>
 <20170510.215218.2185526627014393313.davem@davemloft.net>
 <CAHgaXdKZ_v+iO7uqEDx7PA7D+xcp1FngGvJ1SRSsGXNQ-iWWDQ@mail.gmail.com>
 <CAHgaXdLJoVUXXGTYs7FYXay5wx=sA-O+=dYhX+r7AQT7vSNfGQ@mail.gmail.com>
Message-ID: <CAGXu5j+2q4Wwfhuk_DnDaV894A9ZOD=A_AvAU_OZG6KQv0_KMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 2:32 AM, Shubham Bansal
<illusionist.neo@gmail.com> wrote:
> What do you guys suggest i should implement it? I am almost done with
> my current implementation but if you think I should change it to the
> way David suggested, its better to suggest now before I send the
> patch.

I'd say send what you have right now, as it's a good starting point
for future work. I'll be curious to see the benchmarks, etc. It can be
a base for further optimization.

Thanks for chipping away at this!

-Kees

-- 
Kees Cook
Pixel Security
