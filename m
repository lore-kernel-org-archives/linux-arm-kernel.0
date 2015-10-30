From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Oct 2015 16:01:07 +0000
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <CAKv+Gu-m7dJbiF=8i=+cN=bx+y8AKu_MgHrS29jNK0fTvuwQ5Q@mail.gmail.com>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <562EA894.8070505@arm.com> <562EAA22.3010905@arm.com>
 <CAKv+Gu-G1YS9Ha=-rtnPKJTOxBTrdSq6=Tqwq_GPW742JUE+2Q@mail.gmail.com>
 <562F8DCE.4010308@arm.com>
 <CAKv+Gu-m7dJbiF=8i=+cN=bx+y8AKu_MgHrS29jNK0fTvuwQ5Q@mail.gmail.com>
Message-ID: <20151030160107.GA8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 01:17:24PM +0100, Ard Biesheuvel wrote:
> On 27 October 2015 at 23:44, Jeremy Linton <jeremy.linton@arm.com> wrote:
> > On 10/26/2015 09:20 PM, Ard Biesheuvel wrote:
> >>
> >> Thanks for the report. The following patch should fix it
> >
> >
> > Ard,
> >
> > Thanks, it does fix the build problem...
> >
> > Now to get the darn thing to boot (not related to this AFAIK).
> 
> Would you like me to resend this as a separate patch?

No need to but it would be good to get an Ack from Matt since it touches
drivers/firmware/efi/libstub/Makefile (the patch introducing
STUBCOPY_FLAGS was already acked).

-- 
Catalin
