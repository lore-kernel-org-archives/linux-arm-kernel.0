From: diana.craciun@freescale.com (Diana Craciun)
Date: Wed, 9 Oct 2013 16:06:18 +0300
Subject: [PATCH 3/3] KVM: ARM: Add support for Cortex-A7
In-Reply-To: <CAFEAcA9muNxMtSQHqrByk6Gjw4iWS=vF33T=R42tvAQSTLiAeA@mail.gmail.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
 <1380210568-23175-4-git-send-email-jonathan.austin@arm.com>
 <20130926161743.GD1389@cbox> <52446A48.9070501@arm.com>
 <CA+eFSM1YdhBDMAvyXknMA62Ao3CEntMptdi7RD=NXis1F-BmfQ@mail.gmail.com>
 <CAFEAcA9muNxMtSQHqrByk6Gjw4iWS=vF33T=R42tvAQSTLiAeA@mail.gmail.com>
Message-ID: <525554CA.9030503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2013 05:56 PM, Peter Maydell wrote:
> On 6 October 2013 23:03, Gavin Guo <gavin.guo@canonical.com> wrote:
>> Does it mean the currently qemu can't support A15 vcpu running on host A7?
> No, that's a kernel restriction. That is why the patch description reads:
> # This patch adds support for running Cortex-A7 guests on Cortex-A7 hosts.
>
> (What QEMU is currently missing is A7 support, so you can't ask it to
> run an A7 guest CPU.)

Does anybody know if anybody is planning on adding support for A7 in QEMU?

Thanks,

Diana
