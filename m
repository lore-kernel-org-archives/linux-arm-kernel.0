From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Sep 2016 14:26:44 +0800
Subject: [PATCH v3] ARM: dts: add gpio-ranges property to iMX GPIO
 controllers
In-Reply-To: <1473386556-1934-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1473386556-1934-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <20160909062302.GK16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 05:02:36AM +0300, Vladimir Zapolskiy wrote:
> To establish a connection between GPIO controllers and pin multiplexor
> controller add gpio-ranges properties to all GPIO controllers found
> on iMX50, iMX6Q/D, iMX6DL/S, iMX6SL, iMX6SX, iMX6UL and iMX7D/S
> SoCs. The change was done after human parsing of output from
> 
> % gawk -n '{ sub(/.*__/, ""); if ($1 ~ "^GPIO") print $1, $2/4}' imxXX-pinfunc.h | sort -n
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Applied, thanks.
