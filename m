From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Oct 2013 14:36:47 -0400 (EDT)
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <CAFEAcA8QQyDyvssamsb8s8ydfHGT8V0FQE-wGYt_kRbRMv9GSQ@mail.gmail.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk> <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com> <20131022150426.GF29341@beef>
 <alpine.LFD.2.03.1310221333300.1951@syhkavp.arg>
 <CAFEAcA8QQyDyvssamsb8s8ydfHGT8V0FQE-wGYt_kRbRMv9GSQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1310221435100.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Oct 2013, Peter Maydell wrote:

> On 22 October 2013 18:42, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > Having "stable" DT bindings is just a dream.  Experience so far is
> > showing that this is neither practical nor realistic.
> >
> > The unstructured free-for-all approach isn't good either.  Some
> > compromise between the two extremes needs to be found.
> 
> While I entirely agree that the concept of DT bindings as stable
> ABI is a complete pipe dream, it would be nice if we could have
> some suitably restricted parts of it that are defined as stable,
> for the benefit of tools like kvmtool and QEMU which construct
> device tree blobs from scratch to describe the virtual machine
> environment. (That means roughly CPUs, RAM, virtio-mmio
> devices and a UART at least.)

This subset is probably uncontroversial and easy.


Nicolas
