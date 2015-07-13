From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 13 Jul 2015 16:32:53 +0300
Subject: Extensions for KVM MSI related ioctls
In-Reply-To: <55A3B090.6090002@redhat.com>
References: <55A39231.4050904@arm.com> <55A3B090.6090002@redhat.com>
Message-ID: <03b901d0bd70$6c2f4b50$448de1f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> I think I prefer the flag.  Offhand it sounds easier to add support for
> it to non-ARM architectures, compared to KVM_IRQ_ROUTING_EXTENDED_MSI.

 Actually i also voted for flag, because it is already introduced in (2), and i'm not a fan of
adding new definitions where we can reuse existing ones. IMHO using flag would make an API more
consistent.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
