From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Mon, 10 Dec 2012 18:23:44 +0100
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <20121207134929.GA1969@linaro.org>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
 <20121204221851.GJ14363@n2100.arm.linux.org.uk>
 <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
 <20121205235836.GR14363@n2100.arm.linux.org.uk>
 <20121207122809.GT14363@n2100.arm.linux.org.uk>
 <20121207134929.GA1969@linaro.org>
Message-ID: <CAHod+GcXC=SY-=KZecwtbbH6VVSrdXX7jHGPX98rKxdAQrfdMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I've posted a separate patch which ought to accomplish the appropriate
> change to safe_svc_maskall
> ([PATCH] ARM: head: Remove boot-time HYP mode check for v5 and below)
>
> I've done a compile-disassemble sanity-check for v5 and v7 to make sure
> that the results are sane, but I can't check whether it fixed the
> problem for the affected hardware.
>
> Marko, can you give it a try?
>
> Cheers
> ---Dave
>

Yes, your patch fixes the problem. With this patch the kernel boots with the
correct machine ID.
