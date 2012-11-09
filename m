From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 10 Nov 2012 00:51:19 +1100
Subject: [kvmarm] [PATCH v3 01/13] KVM: ARM: Introduce
 KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <CAFEAcA8FkmNhiemrLaWLGA8=dToHgnwJdrmOknffgLE18sULBg@mail.gmail.com>
References: <20121022065104.18672.52989.stgit@ubuntu>
 <20121022065122.18672.86203.stgit@ubuntu>
 <CAFEAcA8FkmNhiemrLaWLGA8=dToHgnwJdrmOknffgLE18sULBg@mail.gmail.com>
Message-ID: <1352469079.5117.1.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-11-09 at 14:45 +0100, Peter Maydell wrote:
> On 22 October 2012 08:51, Christoffer Dall
> <c.dall@virtualopensystems.com> wrote:
> > +struct kvm_device_address {
> > +       __u32 id;
> > +       __u64 addr;
> > +};
> 
> Ben suggested that this should either be a 64 bit id or have explicit
> padding. Other than that I think that our current proposed ABI for
> ARM irqchips is in line with the discussion we just had at KVM Forum
> for handling non-x86 in-kernel irqchips [hopefully somebody will
> write the details of that up...]
> 
> Ben, do I have that right?

I believe it is :-)

Cheers,
Ben.
