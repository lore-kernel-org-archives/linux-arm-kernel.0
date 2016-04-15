From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 15 Apr 2016 23:15:16 +0100
Subject: [PATCH] efi/arm64: don't apply MEMBLOCK_NOMAP to UEFI memory map
 mapping
In-Reply-To: <CAPvkgC0Dy1c78LOR53PgyTdDom=fWF9RurJHQ02RuMVj5Pch3g@mail.gmail.com>
References: <1459323983-9120-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160331203520.GB2736@codeblueprint.co.uk>
 <CAPvkgC0Dy1c78LOR53PgyTdDom=fWF9RurJHQ02RuMVj5Pch3g@mail.gmail.com>
Message-ID: <20160415221516.GU2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Apr, at 05:44:02PM, Steve Capper wrote:
> 
> Hello,
> Is this going to make it in for 4.6?
> I ran into this issue the other day, and can confirm that Ard's patch
> is helpful.

Good question.

Ingo did you send the patch in the last EFI urgent pull request to
Linus yet? I can find it in tip/efi-urgent-for-linus but not in Linus'
tree.
