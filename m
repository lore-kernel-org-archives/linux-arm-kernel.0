From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 13:25:49 -0400
Subject: [PATCHv3 4/4] arm: orion5x: correct IRQ used in dtsi for mv_cesa
In-Reply-To: <1364334289-19669-5-git-send-email-alex@digriz.org.uk>
References: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
 <1364334289-19669-5-git-send-email-alex@digriz.org.uk>
Message-ID: <20130328172549.GZ13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 09:44:49PM +0000, Alexander Clouter wrote:
> The crypto functionality in the orion5x dtsi uses the Ethernet IRQ and
> so things do not work and there is much grumbling at boot time.
> The IRQ for the crypto should be 28, and not 22, and that is what this
> patch corrects.
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/boot/dts/orion5x.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/fixes

thx,

Jason.
