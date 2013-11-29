From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 15:53:04 +0100
Subject: [PATCH 28/31] ARM: tegra: remove legacy clock entries from DT
In-Reply-To: <1384548866-13141-29-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-29-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129145303.GH9712@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:23PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Now that all Tegra drivers have been converted to use the common reset
> framework, we can remove all the legacy DT clocks/clock-names entries for
> "clocks" that were only used with the old custom Tegra module reset API.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi |  3 +--
>  arch/arm/boot/dts/tegra30.dtsi | 18 +++---------------
>  2 files changed, 4 insertions(+), 17 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/0b621f35/attachment-0001.sig>
