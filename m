From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 04 Aug 2015 10:35:59 +0300
Subject: [PATCH v3 1/2] PCI: generic: remove dependency on hw_pci
In-Reply-To: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
References: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
Message-ID: <00b601d0ce88$35b2f8a0$a118e9e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> Notes:
>  - passing a zeroed out pci_sys_data for ARM looks ok, but I haven't
>    tested it on ARM.
>  - tested it on ARM64 fast model
>  - Any information on how this can be tested on arm is welcome.

 I have tested it on SMDK5410, works OK. By the way, PCI generic is missing MSI support, i had to
add it. I can share the patch if interested, it's very small.

Tested-by: Pavel Fedin <p.fedin@samsung.com>

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
