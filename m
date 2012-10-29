From: zonque@gmail.com (Daniel Mack)
Date: Mon, 29 Oct 2012 11:48:40 +0100
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
 <CACTFLAOwUsWbqK-R1OLNfNTnkp7Mo3hFwu78dFKT8i8goTgdKw@mail.gmail.com>
 <CA+E=qVeup8QzqAiURzEfG8a2vp_rBJ-by8FORLEzSCfkxiyjtQ@mail.gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
Message-ID: <508E5F08.30103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.10.2012 11:07, Vasily Khoruzhick wrote:
> On Mon, Oct 29, 2012 at 12:42 PM, Daniel Mack <zonque@gmail.com> wrote:
>> Please have a quick look at arch/arm/mach-pxa/pxa-dt.c - what it takes
>> for basic 270 support is just copying the logic that is there already
>> for the 3xx models.
> 
> Sure, but I need to get DT-capable bootloader working on Z2 in first
> place, right?

No, you don't necessarily. You can also append a dtb blob to the kernel
image (CONFIG_ARM_APPENDED_DTB).
