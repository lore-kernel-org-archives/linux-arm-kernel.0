From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 21 Mar 2017 22:10:41 +0000
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <20170321193933.GB31111@cbox>
References: <1489996534-8270-1-git-send-email-gengdongjiu@huawei.com>
 <7055772d-2a20-6e0c-2bf8-204bc9ef52a5@arm.com>
 <b912c293-4314-7c90-30a4-2f986feb1670@huawei.com>
 <22fb583f-a33e-15f8-a059-fb112b27dd4f@arm.com> <58CFF058.8020205@arm.com>
 <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
 <20170321113428.GC15920@cbox>
 <58D17AF0.2010802@arm.com> <20170321193933.GB31111@cbox>
Message-ID: <CAFEAcA_NBvRQpuXJ2iZs_8n3b6920Z6E5ueuiAeF-4JCcqPRxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2017 at 19:39, Christoffer Dall <cdall@linaro.org> wrote:
> My confusion here comes from not thinking about QEMU or KVM as firmware,
> but as the machine, so it would be sort of like the functionality is
> baked into hardware rather than firmware.

There is precedent for that kind of thing -- we implement PSCI
in KVM/QEMU for the guest, though in real hardware it would be
provided by firmware at EL3.

thanks
-- PMM
