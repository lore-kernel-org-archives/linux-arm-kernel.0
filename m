From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 29 Jun 2015 11:26:10 +0200
Subject: [PATCH v3 6/6] apf27: dt: add support of internal rtc
In-Reply-To: <1434820360-21935-7-git-send-email-tremyfr@gmail.com>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
 <1434820360-21935-7-git-send-email-tremyfr@gmail.com>
Message-ID: <20150629092610.GY485@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/2015 at 19:12:40 +0200, Philippe Reynes wrote :
> Enable the internal mxc rtc driver on apf27.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/boot/dts/imx27-apf27.dts |    4 ++++
>  arch/arm/boot/dts/imx27.dtsi      |   10 ++++++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 

I'm not the one taking the patch but I usually separate the addition in
the dtsi from the use in the dts in different patches. But it is up to
Shawn to share his preference.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
