From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 26 Apr 2013 16:19:13 +0100
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <1577576.O1Cm2pf5KD@wuerfel>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <CAFEAcA_xmrHTvR7FxUr3PCKBJY-hZnkeBcqyHksTB4-hqOZS0w@mail.gmail.com>
 <CALrVBkuOmu4u9egdzzfn1tU9B-CFe3w85HZQ9s2gpKvYnaSqvA@mail.gmail.com>
 <1577576.O1Cm2pf5KD@wuerfel>
Message-ID: <CAFEAcA9Vp0H9TMqHg+R+Kv0TzrQoCAt0Gr9c9DE94omp78XXig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2013 13:33, Arnd Bergmann <arnd@arndb.de> wrote:
> Couldn't kvmtool implement the interface used by smh_printch()
> for early output instead?
>
> Or if that's not a fitting inteface, maybe a psci call for writing
> a character to the console?

I suggested that earlier:
https://lists.cs.columbia.edu/pipermail/kvmarm/2013-April/005433.html

and Alex pointed out that s390-virtio experience with that
approach is that it's awkward for userspace.

-- PMM
