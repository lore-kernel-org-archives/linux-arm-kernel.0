From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 5 Sep 2017 17:07:01 +0200
Subject: [PULL 0/8] KVM/ARM Changes for v4.14
In-Reply-To: <20170905145207.18447-1-cdall@linaro.org>
References: <20170905145207.18447-1-cdall@linaro.org>
Message-ID: <CAMJs5B_jCsWupkGZOeRz-H4jApfDojV4V_52Q9ccjE1OyCT1qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 5, 2017 at 4:51 PM, Christoffer Dall <cdall@linaro.org> wrote:
> Hi Paolo and Radim,
>
> Here are the changes for KVM/ARM for v4.14.
>
> The changes are mostly bug fixes which are cc'ed stable.
>
> We also have some minor cleanups and improvements, including added
> support for migrating the active priority of interrupts when running a
> GICv2 guest on a GICv3 host.
>
> Sorry about arriving with these rather late.
>
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v4.14
>
> for you to fetch changes up to f3470ce68ee2917ea17d27521b379af117b48c02:
>
>   KVM: arm/arm64: Support uaccess of GICC_APRn (2017-09-05 16:46:30 +0200)
>
>

Whoops, it would appear that Marc already sent you the first two.
Please ignore this request, I'll send another.

Thanks,
-Christoffer
