From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Jan 2015 18:02:03 +0000
Subject: [PATCH] arm64/efi: move virtmap init to early initcall
In-Reply-To: <CAKv+Gu-TLnXOHtq1+rWJRPdLbTfau0t_c0+2KAbqk85wrF1zDg@mail.gmail.com>
References: <1421920900-27028-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150122155924.GC28096@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-TLnXOHtq1+rWJRPdLbTfau0t_c0+2KAbqk85wrF1zDg@mail.gmail.com>
Message-ID: <20150122180202.GD28096@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 05:37:58PM +0000, Ard Biesheuvel wrote:
> On 22 January 2015 at 15:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Jan 22, 2015 at 10:01:40AM +0000, Ard Biesheuvel wrote:
> >> Now that the create_mapping() code in mm/mmu.c is able to support
> >> setting up kernel page tables at initcall time, we can move the whole
> >> virtmap creation to arm64_enable_runtime_services() instead of having
> >> a distinct stage during early boot. This also allows us to drop the
> >> arm64-specific EFI_VIRTMAP flag.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Applied. Thanks.
> 
> Wow that was quick. I noticed that you mangled my S-o-b line though:
> not something I care deeply about, just a FYI

Interesting. I have a script to use the message-id and download the raw
message from gmane.org (as our email system doesn't like patches). For
some strange reason, it converts your email address but not Laura's (I
used exactly the same script with her patches).

-- 
Catalin
