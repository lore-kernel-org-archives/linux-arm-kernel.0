From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 17:53:14 -0800
Subject: [GIT PULL 1/3] ARM: dts: exynos: DT for v4.10
In-Reply-To: <1478629589-7520-3-git-send-email-krzk@kernel.org>
References: <1478629589-7520-1-git-send-email-krzk@kernel.org>
 <1478629589-7520-3-git-send-email-krzk@kernel.org>
Message-ID: <20161118015314.GO8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2016 at 08:26:28PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Hurray! New board! ... Exynos4415 slowly is going away.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.10
> 
> for you to fetch changes up to 05a3589f46f913fbe91704f12fdca46a0eb0a27b:
> 
>   ARM: dts: exynos: Add SCU device node to exynos4.dtsi (2016-11-05 17:39:50 +0200)
> 
> ----------------------------------------------------------------
> Samsung DeviceTree update for v4.10:
> 1. Add TOPEET itop core and Elite boards, based on Exynos4412.
> 2. Remove the Exynos4415 DTSI. We did not have any mainlined boards
>    using it. I am also not aware of any popular out-of-tree boards using it.
> 3. Add Snoop Control Unit node for Exynos4.
> 4. Minor cleanups.

Merged, thanks.


-Olof
