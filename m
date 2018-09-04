From: bp@alien8.de (Borislav Petkov)
Date: Tue, 4 Sep 2018 09:28:58 +0200
Subject: [PATCH v3] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1536033055-25522-1-git-send-email-wufan@codeaurora.org>
References: <1536033055-25522-1-git-send-email-wufan@codeaurora.org>
Message-ID: <20180904072858.GA32615@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 03:50:55AM +0000, Fan Wu wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>
> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> Tested-by: Toshi Kani <toshi.kani@hpe.com>

Those two tags I did see being given to you ...

> Reviewed-by: Borislav Petkov <bp@alien8.de>
> Reviewed-by: James Morse <james.morse@arm.com>
> Reviewed-by: tanxiaofei <tanxiaofei@huawei.com>

... but how in the world did you come up with those?

Do you understand how Reviewed-by works or do you need to look at
Documentation/process/submitting-patches.rst, section 13 ?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
