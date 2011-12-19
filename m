From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 19 Dec 2011 13:30:42 +0800
Subject: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
In-Reply-To: <8B50F2A0-3991-4127-B3D9-5D69C70F87EF@marvell.com>
References: <87r51fwxgt.fsf@laptop.org>
 <1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <874nxkmaky.fsf@laptop.org> <m2sjklfmuf.fsf@bob.laptop.org>
 <CAN1soZxmKct+qGUE2_W+FZufR+gcYZu6Dsj+TkJ06PaO8rV-TQ@mail.gmail.com>
 <4EEEC3BF.6010708@einfochips.com>
 <CAN1soZxnSsZ8SDp=ueu0iMaz59pq7p09DoYD27qCridrrAkmuw@mail.gmail.com>
 <8B50F2A0-3991-4127-B3D9-5D69C70F87EF@marvell.com>
Message-ID: <CAN1soZzDR-iH8mkiDaugZ1bo+=fj6MDYxUEh92Pu52XaMDepPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 1:24 PM, Philip Rakity <prakity@marvell.com> wrote:
>
> Haojian,
>
> Should the APMU definitions be moved to a separate include for pxa168 and say given the name pxa168_apmu.h ?
>
> Same comment applies to all the register set since they are not really common.
>
> Philip

I think it's unnecessary to create a new apmu.h. We can distinguish
them by name in macro, as PXA168/MMP2.

Thanks
Haojian
