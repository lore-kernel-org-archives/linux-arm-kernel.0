From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Jul 2014 08:52:32 -0400
Subject: [PATCHv3 6/7] ARM: mvebu: update mvebu_v7_defconfig with
 cpufreq support
In-Reply-To: <1404920715-19834-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140716125232.GX13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 05:45:14PM +0200, Thomas Petazzoni wrote:
> Now that the Armada XP supports dynamic CPU frequency scaling, it
> makes sense to enable the cpufreq subsystem in mvebu_v7_defconfig, as
> well as the cpufreq-generic driver used on Armada XP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
