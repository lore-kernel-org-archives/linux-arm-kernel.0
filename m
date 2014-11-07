From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Nov 2014 10:07:41 +0000
Subject: [GIT PULL] arm64: UEFI updates for 3.19
In-Reply-To: <20141107100434.GA32336@arm.com>
References: <CAKv+Gu8LEFvdu99vCHbHGPmGLpHWdT+Wb2DECzBEEg8g_yynvg@mail.gmail.com>
 <CAKv+Gu8bpgGWRbgdGYHSy515LOXapCm4stv5xJo_tNNhahcTYw@mail.gmail.com>
 <20141107100434.GA32336@arm.com>
Message-ID: <20141107100740.GB29148@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 10:04:35AM +0000, Will Deacon wrote:
> On Fri, Nov 07, 2014 at 07:34:12AM +0000, Ard Biesheuvel wrote:
> > You are not going to believe this, but I received a report about boot
> > failures on legacy (non-EFI) x86 using the SMBIOS 3.0 code, so could
> > you please hold off on pulling this until we know what is going on
> > there? This does not affect ARM at all, but I may need to update patch
> > 'dmi: add support for SMBIOS 3.0 64-bit entry point' to drop the
> > SMBIOS 3.0 check in the non-EFI code path.
> 
> D'oh, I put this into -next last night (perhaps that's where the report came
> from), so I'll recreate that branch now without your series.
> 
> Please send another pull request without the SMBIOS patch, then we can
> perhaps add that on top later on (that way it's easier to revert in the
> future :).

You have a typo: s/perhaps/never/

;)

-- 
Catalin
