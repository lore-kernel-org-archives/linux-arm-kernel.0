From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 12 Nov 2013 18:30:22 +0100
Subject: [PATCH v2 0/5] ata: Add APM X-Gene SATA controller support
In-Reply-To: <5282589C.2090606@cogentembedded.com>
References: <1383980431-6572-1-git-send-email-lho@apm.com>
 <3056580.hyyOnlSqg9@amdc1032> <5282589C.2090606@cogentembedded.com>
Message-ID: <2501719.LnLBBqadQB@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei,

On Tuesday, November 12, 2013 08:34:36 PM Sergei Shtylyov wrote:
> Hello.
> 
> On 12-11-2013 19:40, Bartlomiej Zolnierkiewicz wrote:
> 
> > Please remember to include linux-ide at vger.kernel.org on CC: for ATA patches.
> 
> > Also from the quick look it seems that:
> > - patch #4 ("ata: Add APM X-Gene SATA serdes functions") should come before
> >    patch #3 ("ata: Add APM X-Gene SATA driver") as code in patch #3 depends
> >    on the code in patch #4
> > - patch #5 ("Documentation: Add documentation for APM X-Gene SATA DTS
> >    binding") should come before patch #2 ("arm64: Add APM X-Gene DTS entry
> >    for SATA controllers") or (even better) just be merged into patch #2
> 
>     No, if it has to be merged then to the driver patch, not .dts patch.

Oh, yes.  Driver patch is where these bindings are actually introduced.

Also .dts patch (adding actual users of bindings) should ideally come last.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
