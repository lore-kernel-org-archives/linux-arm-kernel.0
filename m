From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 17 Mar 2017 10:46:06 +0000
Subject: [PATCH v33 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170315095941.25119-2-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-2-takahiro.akashi@linaro.org>
Message-ID: <1489747566.17202.19.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-15 at 18:59 +0900, AKASHI Takahiro wrote:
> 
> +???????pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> +???????????????crash_base, crash_base + crash_size, crash_size >> 20);

There's a typo there ? it says MB but you mean MiB.

Unless you meant crash_size / 1000000 and not crash_size >> 20?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/3836048c/attachment.bin>
