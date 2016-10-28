From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Oct 2016 10:11:07 -0700
Subject: [GIT PULL] Broadcom ARM64 Device Tree fixes for 4.9
In-Reply-To: <1477331005-32163-1-git-send-email-f.fainelli@gmail.com>
References: <1477331005-32163-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <690f5840-10b4-b9a8-b333-ab4876c49a5a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 10:43 AM, Florian Fainelli wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/devicetree-arm64-fixes
> 
> for you to fetch changes up to 963d790468a2f581abf039b45edac79af5e16e55:
> 
>   arm64: dts: Updated NAND DT properties for NS2 SVK (2016-10-23 14:50:20 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains a single fix for Broadcom ARM64-based SoCs:
> 
> - Ray adds the required bus width and OOB sector size properties to the
>   Northstar 2 SVK reference board in order for the NAND controller to work
>   properly
> 
> ----------------------------------------------------------------
> Ray Jui (1):
>       arm64: dts: Updated NAND DT properties for NS2 SVK
> 
>  arch/arm64/boot/dts/broadcom/ns2-svk.dts | 2 ++
>  1 file changed, 2 insertions(+)

Arnd, Kevin, Olof,

Can you take this change? Thanks!
-- 
Florian
