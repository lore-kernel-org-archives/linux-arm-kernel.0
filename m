From: wufan@codeaurora.org (wufan)
Date: Tue, 4 Sep 2018 07:22:25 -0600
Subject: [PATCH v3] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <20180904072858.GA32615@zn.tnic>
References: <1536033055-25522-1-git-send-email-wufan@codeaurora.org>
 <20180904072858.GA32615@zn.tnic>
Message-ID: <003601d44452$531d4060$f957c120$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Tuesday, September 4, 2018 1:29 AM
> To: Fan Wu <wufan@codeaurora.org>
> Cc: mchehab at kernel.org; james.morse at arm.com; baicar.tyler at gmail.com;
> linux-edac at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; john.garry at huawei.com; toshi.kani at hpe.com;
> tanxiaofei at huawei.com; wanghuiqiang at huawei.com;
> shiju.jose at huawei.com
> Subject: Re: [PATCH v3] EDAC, ghes: use CPER module handles to locate
> DIMMs
> 
> On Tue, Sep 04, 2018 at 03:50:55AM +0000, Fan Wu wrote:
> > For platforms whose firmwares provide valid module handles (SMBIOS
> > type 17) in error records, this patch uses the module handles to
> > locate corresponding DIMMs and enables per-DIMM error counter update.
> >
> > Signed-off-by: Fan Wu <wufan@codeaurora.org>
> > Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> > Tested-by: Toshi Kani <toshi.kani@hpe.com>
> 
> Those two tags I did see being given to you ...
> 
> > Reviewed-by: Borislav Petkov <bp@alien8.de>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > Reviewed-by: tanxiaofei <tanxiaofei@huawei.com>
>
> ... but how in the world did you come up with those?

Sorry. Will remove these in v4. 
Thanks,
Fan

 
> Do you understand how Reviewed-by works or do you need to look at
> Documentation/process/submitting-patches.rst, section 13 ?
> 
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
