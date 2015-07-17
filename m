From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 17 Jul 2015 13:21:23 +0300
Subject: [PATCH v2 3/7] KVM: irqchip: convey devid to kvm_set_msi
In-Reply-To: <55A8D44A.3030105@redhat.com>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <1436430137-24205-4-git-send-email-eric.auger@linaro.org>
 <01d401d0c062$086c2ee0$19448ca0$@samsung.com> <55A8D44A.3030105@redhat.com>
Message-ID: <029401d0c07a$55a3ddd0$00eb9970$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >> > +	} else if (!msi->flags)
> >> > +		return -EINVAL;
> >  Did you mean "if (msg->flags)" here (inverted condition)?
> 
> Indeed, and also you need { } around the return for the QEMU coding
> standard.

 It's kernel and not qemu :)

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
