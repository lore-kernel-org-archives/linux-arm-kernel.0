From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 13:25:09 -0400
Subject: [PATCHv3 1/4] arm: orion5x: fix orion5x.dtsi gpio parameters
In-Reply-To: <1364334289-19669-2-git-send-email-alex@digriz.org.uk>
References: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
 <1364334289-19669-2-git-send-email-alex@digriz.org.uk>
Message-ID: <20130328172509.GY13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 09:44:46PM +0000, Alexander Clouter wrote:
> orion5x.dtsi is missing the gpio alias as well as including a typo
> ('ngpio' instead of 'ngpios') that prevented the orion-gpio driver
> from loading.  Also missing were the interrupt-controller properties.
> This patches resolves those glitches.
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/boot/dts/orion5x.dtsi |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied to mvebu/fixes

thx,

Jason.
