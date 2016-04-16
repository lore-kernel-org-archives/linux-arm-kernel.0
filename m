From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Sat, 16 Apr 2016 11:27:17 +0100
Subject: [PATCH] efi/arm64: don't apply MEMBLOCK_NOMAP to UEFI memory map
 mapping
In-Reply-To: <20160416090910.GA30739@gmail.com>
References: <1459323983-9120-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160331203520.GB2736@codeblueprint.co.uk>
 <CAPvkgC0Dy1c78LOR53PgyTdDom=fWF9RurJHQ02RuMVj5Pch3g@mail.gmail.com>
 <20160415221516.GU2829@codeblueprint.co.uk>
 <20160416090910.GA30739@gmail.com>
Message-ID: <20160416102717.GX2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Apr, at 11:09:10AM, Ingo Molnar wrote:
> 
> I just sent it to Linus.
> 
> It got delayed a bit because it had an x86/urgent dependency that had to be sent 
> upstream first. (In the future you can avoid such delays by basing EFI urgent 
> fixes on an upstream -rc kernel, not x86/urgent.)

Noted. I'll do this in future, thanks Ingo.
