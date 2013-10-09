From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Oct 2013 09:21:49 -0400
Subject: [PATCH v3 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20131008205617.079142b6@armhf>
References: <20131008194232.7d74b9e6@armhf> <525448DE.5030004@gmail.com>
 <20131008181647.GW5402@titan.lakedaemon.net>
 <20131008205617.079142b6@armhf>
Message-ID: <20131009132149.GA5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 08:56:17PM +0200, Jean-Francois Moine wrote:
> This patch activates the audio device of the Cubox.
> 
> The audio flow (pin mpp_audio1) is output on both I2S and S/PDIF.
> 
> The third si5351 clock (#2, pin mpp13) is used as the external clock.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> Jason,
> 
> this patch replaces the previous patch v2 2/2
> 
> v3:
> - move the pins declaration to dove.dtsi (Sebastian Hesselbarth)
> ---
>  arch/arm/boot/dts/dove.dtsi      | 10 ++++++++++
>  arch/arm/boot/dts/dove-cubox.dts |  8 ++++++++
>  2 files changed, 18 insertions(+)

Applied to mvebu/dt with Sebastian's Ack

thx,

Jason.
