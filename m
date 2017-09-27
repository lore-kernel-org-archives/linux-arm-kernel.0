From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Sep 2017 09:19:49 +0200 (CEST)
Subject: [PATCH v9] ACPI / init: Invoke early ACPI initialization earlier
In-Reply-To: <e4eadcbc-fe58-2d2c-818d-34e2f545db16@cn.fujitsu.com>
References: <1505293975-26005-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1505294274-441-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <e4eadcbc-fe58-2d2c-818d-34e2f545db16@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.20.1709270917590.1945@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Sep 2017, Dou Liyang wrote:

> Hi Rafael, Zheng,
> 
> Welcome any comments!
> 
> Now, our patches are in tip tree, they are based on this
> independent patch, we hope it can be merged earlier than our
> patches to avoid ACPI Error. we need your advice and confirmation.

You should have included that patch into your APIC series so I would have
been aware that it's required for the APIC changes to work on all
platforms.

But not a big problem. I merge it through tip/x86/apic so the stuff works
as expected.

Thanks,

	tglx
