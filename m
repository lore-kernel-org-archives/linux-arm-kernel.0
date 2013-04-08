From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 8 Apr 2013 16:53:33 +0100
Subject: [PATCH 1/2] ARM: KVM: add architecture specific hook for
 capabilities
In-Reply-To: <1365436039-29564-2-git-send-email-marc.zyngier@arm.com>
References: <1365436039-29564-1-git-send-email-marc.zyngier@arm.com>
 <1365436039-29564-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAFEAcA-WQO7cdi25-Bu5Yj3yN0PgUmEezHpdhR7dfQ_2y+Z0vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2013 16:47, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Most of the capabilities are common to both arm and arm64, but
> we still need to handle the exceptions.
>
> Introduce kvm_arch_dev_ioctl_check_extention, which both architectures

"extension" (here and in the code itself).

-- PMM
