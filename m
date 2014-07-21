From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Jul 2014 10:51:57 -0700
Subject: [GIT PULL] omap soc clean-up for v3.17 merge window
In-Reply-To: <20140721123000.GB18374@atomide.com>
References: <20140721123000.GB18374@atomide.com>
Message-ID: <CAOesGMjpvJ5aYsw0ireWDEzYxKMQ3KOU6ofT9anc7dCZdC-3kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 5:30 AM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:
>
>   Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/soc-cleanup
>
> for you to fetch changes up to 3db53918e306d3960bf9e12eea8b2fd3f7d0fd62:
>
>   Merge tag 'for-v3.17/omap-clock-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.17/soc (2014-07-21 00:35:38 -0700)
>
> ----------------------------------------------------------------
>
> SoC specific omap clean-up for v3.17 merge window:
>
> - Changes to PRM and clock related code to help move
>   things to drivers
>
> - Removal of unused ctrl module defines that no longer
>   are needed with things moving to .dts files and
>   drivers
>

Merged, thanks.


-Olof
