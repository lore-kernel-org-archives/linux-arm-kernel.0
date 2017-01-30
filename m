From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Jan 2017 13:29:40 +0100
Subject: [PATCH 2/2] ARM: dts: orion5x-lschl: More consistent naming on
 linkstation series
In-Reply-To: <20170130110730.9310-2-rogershimizu@gmail.com> (Roger Shimizu's
 message of "Mon, 30 Jan 2017 20:07:30 +0900")
References: <20170130110730.9310-1-rogershimizu@gmail.com>
 <20170130110730.9310-2-rogershimizu@gmail.com>
Message-ID: <87lgtsvih7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,
 
 On lun., janv. 30 2017, Roger Shimizu <rogershimizu@gmail.com> wrote:

> DTS files, which includes orion5x-linkstation.dtsi, are named:
>   orion5x-linkstation-*.dts
>
> So we rename the file below:
>   arch/arm/boot/dts/orion5x-lschl.dts
> to the new name:
>   arch/arm/boot/dts/orion5x-linkstation-lschl.dts
>
> Because DTS conversion of this device was just introduced in 4.9, Debian
> is still using legacy device support, other distros are the same,
> so here we won't expect any impact actually.
>
> Fixes: f94f268979a2 ("ARM: dts: orion5x: convert ls-chl to FDT")
> Cc: Ashley Hughes <ashley.hughes@blueyonder.co.uk>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>


Applied on mvebu/dt

Thanks,

Gregory



> ---
>  arch/arm/boot/dts/{orion5x-lschl.dts => orion5x-linkstation-lschl.dts} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename arch/arm/boot/dts/{orion5x-lschl.dts => orion5x-linkstation-lschl.dts} (100%)
>
> diff --git a/arch/arm/boot/dts/orion5x-lschl.dts b/arch/arm/boot/dts/orion5x-linkstation-lschl.dts
> similarity index 100%
> rename from arch/arm/boot/dts/orion5x-lschl.dts
> rename to arch/arm/boot/dts/orion5x-linkstation-lschl.dts
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
