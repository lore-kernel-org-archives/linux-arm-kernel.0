From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 16 Apr 2016 11:09:10 +0200
Subject: [PATCH] efi/arm64: don't apply MEMBLOCK_NOMAP to UEFI memory map
 mapping
In-Reply-To: <20160415221516.GU2829@codeblueprint.co.uk>
References: <1459323983-9120-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160331203520.GB2736@codeblueprint.co.uk>
 <CAPvkgC0Dy1c78LOR53PgyTdDom=fWF9RurJHQ02RuMVj5Pch3g@mail.gmail.com>
 <20160415221516.GU2829@codeblueprint.co.uk>
Message-ID: <20160416090910.GA30739@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Matt Fleming <matt@codeblueprint.co.uk> wrote:

> On Fri, 15 Apr, at 05:44:02PM, Steve Capper wrote:
> > 
> > Hello,
> > Is this going to make it in for 4.6?
> > I ran into this issue the other day, and can confirm that Ard's patch
> > is helpful.
> 
> Good question.
> 
> Ingo did you send the patch in the last EFI urgent pull request to
> Linus yet? I can find it in tip/efi-urgent-for-linus but not in Linus'
> tree.

I just sent it to Linus.

It got delayed a bit because it had an x86/urgent dependency that had to be sent 
upstream first. (In the future you can avoid such delays by basing EFI urgent 
fixes on an upstream -rc kernel, not x86/urgent.)

Thanks,

	Ingo
