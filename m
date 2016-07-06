From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 21:33:20 -0700
Subject: [GIT PULL] ARM: hisi: soc changes for v4.8
In-Reply-To: <5772B754.2080701@hisilicon.com>
References: <5772B754.2080701@hisilicon.com>
Message-ID: <20160706043320.GG23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 28, 2016 at 06:43:48PM +0100, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> Please help to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-armv7-soc-for-4.8
> 
> for you to fetch changes up to c90047616d4411ff6e7a8a40ed87731dda0753b9:
> 
>   ARM: hisi: add compatible string for Hi3519 soc (2016-06-28 16:24:33 +0100)
> 
> ----------------------------------------------------------------
> ARM: mach-hisi: Hisilicon SoC updates for 4.8
> 
> - Add initial support for the hi3519 SoC based on armv7
> - Avoid the compiling warning by making unexported symbols static
> 
> ----------------------------------------------------------------
> Ben Dooks (1):
>       ARM: hisi: make unexported symbols static
> 
> Jiancheng Xue (1):
>       ARM: hisi: add compatible string for Hi3519 soc

This patch does more than this, it consolidates a bunch of machine entries.

Since none of them are needed (the generic machine will match instead), just
remove all of them instead, please.

I'd recommend a future cleanup to do this instead, as I did for Qualcomm, but
since you're already churning this code it's better to do it now.

So, please respin this pull request with the above addressed.

Thanks,


-Olof
