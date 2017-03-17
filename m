From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 17 Mar 2017 11:32:35 +0000
Subject: [PATCH v33 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170317113116.GB11935@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <20170315095941.25119-2-takahiro.akashi@linaro.org>
 <1489747566.17202.19.camel@infradead.org>
 <20170317113116.GB11935@linaro.org>
Message-ID: <1489750355.17202.34.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 20:31 +0900, AKASHI Takahiro wrote:
> 
> Yes and no.
> This notation is consistent with other places like mem_init()
> in mm/init.c.]

Well, perhaps we should fix those too then. But we certainly shouldn't
add *more* errors.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/c2db2ad8/attachment.bin>
