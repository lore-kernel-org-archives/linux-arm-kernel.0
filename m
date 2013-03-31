From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 20:17:26 -0400
Subject: [PATCHv3 3/4] arm: orion5x: enable xor for orion5x platform
In-Reply-To: <1364334289-19669-4-git-send-email-alex@digriz.org.uk>
References: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
 <1364334289-19669-4-git-send-email-alex@digriz.org.uk>
Message-ID: <20130331001726.GE13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 09:44:48PM +0000, Alexander Clouter wrote:
> The orion5x SoC includes DMA functionality, so lets enable that
> and turn it on by default.
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/boot/dts/orion5x.dtsi |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied to mvebu/dt

thx,

Jason.
