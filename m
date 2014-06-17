From: drake@endlessm.com (Daniel Drake)
Date: Tue, 17 Jun 2014 12:45:51 +0100
Subject: [PATCH 0/5] Handle non-secure L2C initialization on Exynos4
In-Reply-To: <539B11EB.6010304@samsung.com>
References: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
 <539B11EB.6010304@samsung.com>
Message-ID: <CAD8Lp47AHrwSx52Oi98HN51_L2pwT2xco9WB0FFP1rUdEucfZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 13, 2014 at 3:59 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> I have attached, three patches which make the kernel boot fine with L2
> cache enabled on ODROID-U3. Could you test them on your setup to verify
> that they indeed fix the issue?

Nice work, now my ODROID-U2 boots fine.

L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
L2C: platform provided aux values permit register corruption.
L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
L2C-310 enabling early BRESP for Cortex-A9
L2C-310: enabling full line of zeros but not enabled in Cortex-A9
L2C-310 ID prefetch enabled, offset 8 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001

Thanks!
Daniel
