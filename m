From: peter.maydell@linaro.org (Peter Maydell)
Date: Sun, 6 Oct 2013 23:56:05 +0900
Subject: [PATCH 3/3] KVM: ARM: Add support for Cortex-A7
In-Reply-To: <CA+eFSM1YdhBDMAvyXknMA62Ao3CEntMptdi7RD=NXis1F-BmfQ@mail.gmail.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
 <1380210568-23175-4-git-send-email-jonathan.austin@arm.com>
 <20130926161743.GD1389@cbox> <52446A48.9070501@arm.com>
 <CA+eFSM1YdhBDMAvyXknMA62Ao3CEntMptdi7RD=NXis1F-BmfQ@mail.gmail.com>
Message-ID: <CAFEAcA9muNxMtSQHqrByk6Gjw4iWS=vF33T=R42tvAQSTLiAeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2013 23:03, Gavin Guo <gavin.guo@canonical.com> wrote:
> Does it mean the currently qemu can't support A15 vcpu running on host A7?

No, that's a kernel restriction. That is why the patch description reads:
# This patch adds support for running Cortex-A7 guests on Cortex-A7 hosts.

(What QEMU is currently missing is A7 support, so you can't ask it to
run an A7 guest CPU.)

-- PMM
