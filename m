From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jun 2016 22:48:46 -0700
Subject: [GIT PULL 4/7] Broadcom devicetree-arm64 changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-4-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
 <1466128575-5378-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160620054846.GG2329@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 06:56:12PM -0700, Florian Fainelli wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/devicetree-arm64
> 
> for you to fetch changes up to 5dcc9c7618dff61de243ca9bbac7de18ef92f49b:
> 
>   arm64: dts: NS2: Add CCI-400 PMU support (2016-05-31 11:00:28 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Device Tree changes for Broadcom ARM64-based SoCS:
> 
> - Anup adds nodes for the AHCI and SATA3 PHY peripherals to the Northstar2 SoCs
> 
> - Dhanajay enables pinctrl for the Northstar2 SoCs
> 
> - Jon Mason enables all of the UART peripherals found in the NS2 SVK and
>   finally adds the CCI-400 and PMU nodes

Merged, thanks.


-Olof
