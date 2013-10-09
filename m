From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 8 Oct 2013 23:20:06 -0700
Subject: New big-endian patch series against 3.12-rc4
In-Reply-To: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAA3XUr31CON02T66_nrV-PsrjyLgzCbXC2WokQeC58z6APAbVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 8 October 2013 15:34, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> This is a new series for big-endian on ARM re-based onto 3.12-rc4
> and updated with new patches from Victor to fix regressions since 3.11.
>
> I have not been able to test this further than building it as I do not
> currently have access to any hardware, however there where no big issues
> when re-basing. Thanks to Marc Zyngier for pointing out the need for a
> rebase.
>
> The branch is at:
>
>   git://git.baserock.org/delta/linux baserock/bjdooks/3.12-rc4/core

It is rather baserock/312-rc4/be/core isn't it?

I've tested baserock/312-rc4/be/core from
git://git.baserock.org/delta/linux on TC2. Both LE and BE images.
Done full LTP runs on both. LTP BE results match LE one.

Thanks,
Victor

> Russell, if possible could this go into -next and then if everything
> I can issue a pull request for it.
>
> Changes since last:
>
> - Updated to 3.12-rc4 to be closer to mainline
> - Added Victor's patches for CCI and TC2 boot
> - Added Victor's patch for ASID extraction
> - Updated Victor's patch with fix for building on older kernels
>
