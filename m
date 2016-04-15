From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 15 Apr 2016 17:44:02 +0100
Subject: [PATCH] efi/arm64: don't apply MEMBLOCK_NOMAP to UEFI memory map
 mapping
In-Reply-To: <20160331203520.GB2736@codeblueprint.co.uk>
References: <1459323983-9120-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160331203520.GB2736@codeblueprint.co.uk>
Message-ID: <CAPvkgC0Dy1c78LOR53PgyTdDom=fWF9RurJHQ02RuMVj5Pch3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 March 2016 at 21:35, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Wed, 30 Mar, at 09:46:23AM, Ard Biesheuvel wrote:
>> Hi Matt,
>>
>> Could we queue this as a fix for v4.6 with a cc:stable for v4.5, please?
>> (assuming no objections from any of the cc'ees)
>
> Yep, I've picked this up. I'll go out to tip tomorrow.
>

Hello,
Is this going to make it in for 4.6?
I ran into this issue the other day, and can confirm that Ard's patch
is helpful.

Cheers,
-- 
Steve

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
