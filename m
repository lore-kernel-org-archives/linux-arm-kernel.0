From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 Apr 2015 12:03:37 +0000
Subject: [PATCH] ARM: mvebu: dove: Relicense the device tree under
 GPLv2+/X11
In-Reply-To: <1430125744-3550-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430125744-3550-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20150427120337.GE8069@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 11:09:04AM +0200, Sebastian Hesselbarth wrote:
> The current implicit GPL only licensing on the device tree makes it
> very impractical for other software components licensed under another
> license.
> 
> In order to make it easier for them to reuse our device trees,
> relicense our device trees under a GPL/X11 dual-license.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Hi,
> 
> with Dove we only have a small set of people who can be git blame'd for
> the DT files:
> - Jason Cooper
> - Ezequiel Garcia
> - Andrew Lunn
> - Jean-Francois Moine
> - Russell King
> - Myself
> 
> so I decided to keep the whole relicensing in a single patch. Please send
> your Acked-by's in reply to this patch if you are happy with the relicensing.
> 
> Thanks,
>   Sebastian
> ---
>  arch/arm/boot/dts/dove-cubox-es.dts | 42 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dove-cubox.dts    | 42 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dove-d2plug.dts   | 42 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dove-d3plug.dts   | 42 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dove-dove-db.dts  | 42 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dove.dtsi         | 42 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 252 insertions(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
