From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 16 Mar 2018 15:53:17 +0100
Subject: arm64 kvm built with clang doesn't boot
In-Reply-To: <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
Message-ID: <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 3:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> I wasn't aware of that discussion, but this is indeed quite annoying.
> Note that you should be able to restrict this to arch/arm64/kvm/hyp/*
> and virt/kvm/arm/hyp/*.

That works as well (tried it, the kernel boots). I've also tried
compiling without the flag for virt/kvm/arm/hyp/*, it boots as well.
