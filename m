From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 22 Nov 2014 09:49:28 +0100
Subject: [PATCH v3 00/13] arm64: stable UEFI mappings for kexec
In-Reply-To: <1416521132.23886.108.camel@smoke>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
 <1416521132.23886.108.camel@smoke>
Message-ID: <CAKv+Gu_Sk=DYy0uhZefhE+43CJudNGuLriYb-veoA5xQNQqYpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2014 23:05, Geoff Levand <geoff@infradead.org> wrote:
> Hi Ard,
>
> On Tue, 2014-11-18 at 13:56 +0100, Ard Biesheuvel wrote:
>> This is v3 of the series to update the UEFI memory map handling for the arm64
>> architecture so that:
>
> I merged in your EFI patches into my master branch [1] and was able
> to do a successful chain of (four) kexec re-boots of the same kernel
> image on the ARM base model running LEG 14.10 EFI binaries [2].  EFI
> showed:
>
>   UEFI v2.40 (ARM Fixed Virtual Platform EFI Oct 23 2014 15:53:09, 0x00000000)
>
> I only verified that all CPU's came up and that /proc/meminfo and the
> /proc/iomem 'System RAM' entries looked ok.
>
> [1] https://git.linaro.org/people/geoff.levand/linux-kexec.git
> [2] https://releases.linaro.org/14.10/components/kernel/uefi-linaro/release/fvp_minimal
>

Good stuff! Thanks for testing this.

Let's align so that we can get this merged in the same cycle.

Thanks,
Ard.
