From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 23 Oct 2016 14:55:10 -0700
Subject: [GIT PULL 4/4] Broadcom defconfig-arm64 changes for 4.9 (part 2)
In-Reply-To: <1475263395-27653-4-git-send-email-f.fainelli@gmail.com>
References: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
 <1475263395-27653-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <62d5c9b0-9073-c8e3-6a9f-390f381d4d9d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2016 12:23 PM, Florian Fainelli wrote:
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/defconfig-arm64
> 
> for you to fetch changes up to 51e3fb1d3f514cd336faf185df73b25fca194773:
> 
>   Merge tag 'bcm2835-defconfig-64-next-2016-09-22' into defconfig-arm64/next (2016-09-30 12:02:29 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoCs defconfig changes for 4.9,
> please pull the following changes:
> 
> - Eric updates the ARMv8 defconfig to contain everything that is needed to run
>   a 64-bit kernel on the Raspberry Pi 3
> 
> ----------------------------------------------------------------
> Eric Anholt (1):
>       arm64: Add BCM2835 (Raspberry Pi 3) support to the defconfig
> 
> Florian Fainelli (1):
>       Merge tag 'bcm2835-defconfig-64-next-2016-09-22' into defconfig-arm64/next
> 
>  arch/arm64/configs/defconfig | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Arnd, Kevin, Olof,

Following Olof's response here:

https://www.spinics.net/lists/arm-kernel/msg534687.html

do you think we could merge these for 4.9-rcX? Let me know if I should
send a fresh pull request for that.

Thank you!
-- 
Florian
