From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Jan 2015 11:08:18 +0900
Subject: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Complete multiplatform
 support
In-Reply-To: <1420809866-4330-1-git-send-email-geert+renesas@glider.be>
References: <1420809866-4330-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150113020818.GB21265@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 02:24:26PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series completes the migration from kzm9g-reference (legacy
> DT based) to kzm9g-multiplatform (ARM multiplatform DT based with
> common clock framework).
> 
>   - The first two patches fix Ethernet on kzm9g, by adding a Bus State
>     Controller node, as introduced in "[PATCH v3 0/4] drivers: bus:
>     Add Simple Power-Managed Bus", and moving the Ethernet node to it,
>   - The third path enables kzm9g support in shmobile_defconfig,
>   - The fourth patch removes all kzm9g-reference support, now the
>     sh73a0 generic multiplatform case has the same feature set
>     (better, it provides 16 MiB more RAM!).
> 
> Thanks for applying!

It seems to me that at the first two patches require the patchset
referenced above in order to work. For that reason I am holding off
on applying this series. I am quite happy to negotiate merging
some or all of this series earlier than later :)
