From: zhlcindy@gmail.com (Li Zhang)
Date: Thu, 18 Oct 2018 17:17:57 +0800
Subject: kvm-unit-tests gicv2 cases fail
Message-ID: <CAD8of+q29DrQa4Ay6karXC19vXzX++2T8FR-V1SAjGuO0ejYhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I run kvm-units-test on ARM server(QDF2400), but gicv2-ipi,
gicv2-active cases fail.
By debuging kvm-unit-tests source code, I found that interrupt is not
handled. do_handle_exception is not called.

By looking into KVM source code, it has GICv2 emulation on GICv3 support.
I've tried a lot of kernel versions, from v4.12~v4.19 in mainline,
these cases always fail.
Is it possible that hardware/software disables this?

It seems that GICv2 is a little old for ARM server, I am confused when
we can use it.
Do we need to care about these cases?

--

Best Regards
-Li
