From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 20:16:57 -0400
Subject: [PATCHv3 2/4] arm: orion5x: add ehci bindings to dtsi
In-Reply-To: <1364334289-19669-3-git-send-email-alex@digriz.org.uk>
References: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
 <1364334289-19669-3-git-send-email-alex@digriz.org.uk>
Message-ID: <20130331001657.GD13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 09:44:47PM +0000, Alexander Clouter wrote:
> The orion5x SoC also includes a USB EHCI componment so lets add that
> to the dtsi (disable by default incase the pins are not broken out).
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/boot/dts/orion5x.dtsi |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied to mvebu/dt

thx,

Jason.
