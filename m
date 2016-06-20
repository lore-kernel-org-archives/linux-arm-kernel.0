From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jun 2016 22:43:09 -0700
Subject: [GIT PULL 1/7] Broadcom soc changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160620054309.GD2329@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 06:56:09PM -0700, Florian Fainelli wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/soc
> 
> for you to fetch changes up to 423779cfd3ca73b9236e6eb798477f3a4f13355d:
> 
>   ARM: bcm: fix missing include of kona_l2_cache.h (2016-06-08 10:17:15 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains SoC changes for Broadcom ARM-based SoCs:
> 
> - Chris prepares support for the BCM23550 by removing reset code in the
>   BCM21664 machine code since a proper drivers/power/reset driver is provided and
>   shared, he then adds a machine entry point for BCM23550 and updates the SMP
>   code to bring-up the secondary cores on BCM23550
> 
> - Ben fixes a warning in the Kona L2 SMC code by adding the missing include file
> 
> ----------------------------------------------------------------

Thanks, merged into next/soc.


-Olof
