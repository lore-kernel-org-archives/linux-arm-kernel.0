From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Mon, 5 Jan 2015 20:42:10 +0530
Subject: [PATCH v7] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <20150105101546.GA19655@pd.tnic>
References: <d71411fd1be84d99af5936138cbcc9c7@BL2FFO11FD014.protection.gbl>
 <20150102105008.GA31364@pd.tnic>
 <CAGnW=BbrpMoMGSVmFXUAYsnyOPGpkz=HbL6mRzB7PqRhbq5HTA@mail.gmail.com>
 <20150105101546.GA19655@pd.tnic>
Message-ID: <CAGnW=BZ9L9uGDNGsz016Vc+mFf_NtVmrmm56HWg1PTYxgxDmVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 5, 2015 at 3:45 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Sat, Jan 03, 2015 at 08:01:29AM +0530, punnaiah choudary kalluri wrote:
>> p is pointing to the stack memory.
>
> So you could go and allocate all that memory at driver init time and
> reuse it each time you handle an error instead of on the stack. This way
> your error handling paths are lean and fast.

Ok. I will update it.

Thanks,
Punnaiah
>
> --
> Regards/Gruss,
>     Boris.
>
> Sent from a fat crate under my desk. Formatting is fine.
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-edac" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
