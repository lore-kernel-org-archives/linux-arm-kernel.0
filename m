From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jun 2016 22:42:11 -0700
Subject: [GIT PULL] arm64: dts: juno updates for v4.8
In-Reply-To: <5768019C.40009@arm.com>
References: <5768019C.40009@arm.com>
Message-ID: <CAOesGMiRiR9Kk6w7O5iPoMCndpN_PpGSJFqYM2pLeEQ5SQ2_+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Mon, Jun 20, 2016 at 7:45 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi ARM-SoC team,
>
> Please pull Juno platform DT updates for v4.8
>
> --
> Regards,
> Sudeep
>
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
>
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> tags/juno-dt-4.8
>
> for you to fetch changes up to da63398bec2be7c247b5e94c9cabc4339fb65e28:
>
>   arm64: dts: juno: add thermal zones for scpi sensors (2016-06-17 16:38:49
> +0100)

Didn't merge because:

>
> ----------------------------------------------------------------
> ARMv8 Vexpress/Juno DT updates for v4.8
>
> 1. Adds various coreSight debug components on Juno boards
>
> 2. Adds SCPI device power domains and use them for coresight components
>
> 3. Adds thermal zones for SCPI sensors on Juno
>
> ----------------------------------------------------------------
> Javi Merino (1):
>       arm64: dts: juno: add thermal zones for scpi sensors
>
> Sudeep Holla (2):
>       arm64: dts: juno: add coresight support

I commented directly on the patch on the list, please see that reply.


-Olof
