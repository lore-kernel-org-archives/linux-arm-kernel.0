From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 7 Jul 2014 21:11:03 +0100
Subject: [PATCH v3] efi/arm64: handle missing virtual mapping for UEFI
 System Table
In-Reply-To: <09C85B92-02BB-45C4-A461-D4E0CD4F7203@arm.com>
References: <1404487509-26084-1-git-send-email-ard.biesheuvel@linaro.org>
 <1404492756.19665.57.camel@deneb.redhat.com>
 <20140704170110.GM16404@arm.com>
 <CAKv+Gu_-=NtVNFLEh35Pv8OO6nLe1YhPjS13MYZa93YOXFOh6Q@mail.gmail.com>
 <09C85B92-02BB-45C4-A461-D4E0CD4F7203@arm.com>
Message-ID: <20140707201103.GB27474@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 05 Jul, at 08:25:35AM, Catalin Marinas wrote:
> 
> OK, I?ll leave it to Matt then together with the other EFI patches
> he?s already queuing.

Thanks guys.

What release are we targetting with this patch? Is it a bug fix for
something likely to affect people? Have there been reports of users
actually hitting this issue?

We're at -rc4 now, so there's still time for getting bug fixes to Linus
but we may start being asked for justification from the tip folks en
route to Linus.

If it's just a case of improving the error paths, can it wait until
v3.17?

-- 
Matt Fleming, Intel Open Source Technology Center
