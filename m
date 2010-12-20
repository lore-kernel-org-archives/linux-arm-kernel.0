From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 20 Dec 2010 09:29:05 +0100
Subject: [PATCH 0/7 v6] OMAP3: clean up ASM sleep code
In-Reply-To: <4D0D3C24.4020503@ti.com>
References: <1292687087-22983-1-git-send-email-j-pihet@ti.com>
	<4D0D3C24.4020503@ti.com>
Message-ID: <AANLkTikX9qY0OUfS6w9UvELCGLM4F1oUVLKYwGq7fZgm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishant,

On Sat, Dec 18, 2010 at 11:56 PM, Nishanth Menon <nm@ti.com> wrote:
> jean.pihet at newoldbits.com had written, on 12/18/2010 09:44 AM, the
> following:
>>
>> Applies on top of Nishant's latest idle path errata fixes step 2,
>> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
>>
>> Jean Pihet (7):
>> ?OMAP3: remove unused code from the ASM sleep code
>> ?OMAP2+: use global values for the SRAM PA addresses
>> ?OMAP3: remove hardcoded values from the ASM sleep code
>> ?OMAP3: re-organize the ASM sleep code
>> ?OMAP3: rework of the ASM sleep code execution paths
>> ?OMAP3: add comments for low power code errata
>> ?OMAP3: ASM sleep code format rework
>>
>
> just FYI - tested the series v6 as well with:
> SDP3430 and SDP3630 with script:
> http://elinux.org/OMAP_Power_Management#Quick_verification_of_suspend-idle_functionality
>
> Tested against v4 of my series. I have ensured that your series still
> applies cleanly on top of my new series.

Thanks for that!

Let me check and ack your latest v4 patches.

>
> --
> Regards,
> Nishanth Menon
>
>

Regards,
Jean
