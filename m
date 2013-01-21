From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 21 Jan 2013 18:17:55 +0000
Subject: [kvmarm] [PATCH v6 14/15] KVM: ARM: Power State Coordination
 Interface implementation
In-Reply-To: <dfd76d65ce8e16c6792a47262d27dda2@localhost>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175918.29147.318.stgit@ubuntu> <50F81EF4.4020507@arm.com>
 <CANM98q+z2tj72qFtjDF1ZpKMGs876=hRLpKTEwYKnpCMzdpErg@mail.gmail.com>
 <75f43582106716efe7c8f1360e58732e@localhost>
 <CANM98q+6wd6YmK--Xb7=rKm7AyHE94pBnC_XsP+6UmuP31CziQ@mail.gmail.com>
 <832da358616729fd6a5d6522682b022f@localhost>
 <CANM98qKDQrfSZC8knciajyeZWcX0CGObuYPrFA_RTEpUzBhBow@mail.gmail.com>
 <dfd76d65ce8e16c6792a47262d27dda2@localhost>
Message-ID: <CAFEAcA_B5WT6z-A2rRAj2Ux8Kp=MVAVwgD8DGxJj=-n+EgMxpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 January 2013 18:08, Marc Zyngier <marc.zyngier@arm.com> wrote:
> I still have hope for QEMU to move forward and eventually generate a DT
> based on the host capabilities.

We might improve our "modify the DT the user passed us" code, but
I don't currently anticipate "generate a DT from scratch". In
my experience using anything other that the DT which came from
the same tree as the kernel itself is just asking for the kernel
to crash with some really obscure and unhelpful error message,
so QEMU generating a DT is just going to result in a pile of
bugs on the QEMU list where users say "new kernel doesn't boot"...

-- PMM
