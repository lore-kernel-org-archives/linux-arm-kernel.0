From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 21 Aug 2014 10:22:12 +0100
Subject: [PATCH v2 3/3] arm64/efi: efistub: don't abort if base of DRAM
 is occupied
In-Reply-To: <CAKv+Gu-3wWQJf6DTSbx68cg4BV9FX4-5t=GQ+06ikvC4M5jSkw@mail.gmail.com>
References: <1406717944-24725-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406717944-24725-4-git-send-email-ard.biesheuvel@linaro.org>
 <20140814113204.GE24018@leverpostej>
 <20140820171057.GG29733@console-pimps.org>
 <20140820173528.GH21734@leverpostej>
 <CAKv+Gu-3wWQJf6DTSbx68cg4BV9FX4-5t=GQ+06ikvC4M5jSkw@mail.gmail.com>
Message-ID: <20140821092212.GI29733@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Aug, at 10:00:40AM, Ard Biesheuvel wrote:
> 
> Hey Matt,
> 
> These patches mostly touch non-EFI specific files under arch/arm64, so
> to prevent conflicts, it makes sense for the arm64 tree to take them.

OK great. Thanks guys.

-- 
Matt Fleming, Intel Open Source Technology Center
