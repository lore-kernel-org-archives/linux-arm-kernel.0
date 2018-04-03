From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 3 Apr 2018 12:56:30 -0700
Subject: [PATCH v5 01/13] ARM: move cputype definitions into another file
In-Reply-To: <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-2-mylene.josserand@bootlin.com>
 <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
Message-ID: <4ba0f1c4-a52a-b9f5-67ac-bf348a13228a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2018 11:52 PM, Chen-Yu Tsai wrote:
> On Tue, Apr 3, 2018 at 2:18 PM, Myl?ne Josserand
> <mylene.josserand@bootlin.com> wrote:
>> To add the support for SMP on sun8i-a83t, we will use some
>> definitions in an assembly file so move definitions into
>> another file to separate C functions and macro defintions.
> 
> Instead of moving the definitions, you could guard all the C
> stuff in "#ifndef __ASSEMBLY__". AFAIK a few header files do that.

Which is effectively what this patch does (still waiting for an ACK):

https://patchwork.kernel.org/patch/10239855/

> 
> ChenYu
> 
>> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
>> ---
>>  arch/arm/include/asm/cputype.h     | 94 +-----------------------------------
>>  arch/arm/include/asm/cputype_def.h | 98 ++++++++++++++++++++++++++++++++++++++
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Florian
