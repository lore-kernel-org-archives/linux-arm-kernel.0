From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 19 Dec 2013 13:07:53 -0500 (EST)
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <CAKv+Gu-1=7ZU+C3NL2_C0BBFkAcOhyZn8UvPtXHUtvwW6PKNYw@mail.gmail.com>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
 <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
 <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
 <20131218105541.GE4360@n2100.arm.linux.org.uk>
 <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
 <20131218112713.GA28112@arm.com>
 <20131218114211.GF4360@n2100.arm.linux.org.uk>
 <20131218120306.GC28112@arm.com> <52B1B0E0.6030104@codeaurora.org>
 <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
 <alpine.LFD.2.10.1312181449580.7480@knanqh.ubzr>
 <CAKv+Gu9jw4RHny3L3L6SWm4anhRguhRe4BkLKAxJeqpPB12igg@mail.gmail.com>
 <alpine.LFD.2.10.1312181550271.7480@knanqh.ubzr>
 <CAKv+Gu-1=7ZU+C3NL2_C0BBFkAcOhyZn8UvPtXHUtvwW6PKNYw@mail.gmail.com>
Message-ID: <alpine.LFD.2.10.1312191306380.7480@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Dec 2013, Ard Biesheuvel wrote:

> On 18 December 2013 22:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > The current hwcaps is
> > certainly not suitable for that level of granularity without a way to
> > extend it.
> >
> 
> There is a way to extend it. It is called HWCAP2, and it is already in
> use by powerpc.

Great.  Shall we do that first then?


Nicolas
