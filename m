From: grundler@chromium.org (Grant Grundler)
Date: Wed, 19 Mar 2014 09:54:39 -0700
Subject: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
 functions
In-Reply-To: <532997D7.6090608@samsung.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
 <5322FD14.5090602@samsung.com>
 <20140318185605.0380c8dfe6559c06183092e5@samsung.com>
 <532861BE.7020601@samsung.com>
 <20140319100304.5e26fa43ccdfc29178b058e1@samsung.com>
 <532997D7.6090608@samsung.com>
Message-ID: <CANEJEGtK-XfTef3ko+Yq2RNFXohhuQjgamr-DRBmxR-SNzgkJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 6:12 AM, Tomasz Figa <t.figa@samsung.com> wrote:
...
>> Device driver is not only for the scholarship but also for the real use.
>
> Huh? I'm not sure what kind of comment is this.

I'm guessing Cho meant: "This isn't an academic exercise - I have a
real use case that requires reference counting."

Cho needs to be more specific about his "Some driver needs enabling
sysmmu" example. Then others would understand why/when the reference
counting is needed. Ie walk through a real driver that exists today
that depends on reference counting.

cheers,
grant
