From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 19 Feb 2014 10:16:16 +0800
Subject: [PATCH v5 2/5] ACPI / processor_core: Rework _PDC related stuff
 to make it more arch-independent
In-Reply-To: <3459962.GkY99aHQbc@vostro.rjw.lan>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org>
 <1392740638-2479-3-git-send-email-hanjun.guo@linaro.org>
 <3459962.GkY99aHQbc@vostro.rjw.lan>
Message-ID: <530413F0.4050008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?02?19? 08:50, Rafael J. Wysocki wrote:
> On Wednesday, February 19, 2014 12:23:55 AM Hanjun Guo wrote:
>> _PDC related stuff in processor_core.c is little bit X86/IA64 dependent,
>> rework the code to make it more arch-independent, no functional change
>> in this patch.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> I've queued up patches [1,3-5/5] from this series for 3.15 (modulo changelog
> modifications), but this one should be CCed to the x86 and ia64 maintainers.

Thanks! I will resend this patch with Tony and Thomas in cc list, so is 
there any chance for this
patch to be merged into 3.15 if I get acked from them?

Best regards
Hanjun
