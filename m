From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jun 2016 22:55:31 -0700
Subject: [GIT PULL 7/7] Broadcom drivers changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-7-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
 <1466128575-5378-7-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160620055531.GJ2329@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 06:56:15PM -0700, Florian Fainelli wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/drivers
> 
> for you to fetch changes up to a536bcc931ed5c047100c3a28f521283749d3b9a:
> 
>   soc: brcmstb: fix warning from missing include (2016-06-07 13:53:42 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains drivers related changes for Broadcom SoCs:
> 
> - Florian moves drivers/soc/brcmstb to drivers/soc/bcm/brcmstb to be consistent with
>   how other SoCs are doing it
> 
> - Chris provides a reset driver which is common to the BCM21664 and BCM23550 SoCs
> 
> - Ben fixes a warning by providing the appropriate include file

Merged, thanks.


-Olof
