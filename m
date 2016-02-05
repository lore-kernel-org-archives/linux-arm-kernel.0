From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 5 Feb 2016 21:48:09 +0100
Subject: [PATCH 2/3] ARM: dts: orion5x: split linkstation lswtgl into
 common and device parts
In-Reply-To: <1454689998-9579-3-git-send-email-rogershimizu@gmail.com>
References: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
 <1454689998-9579-3-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160205204809.GC8063@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 01:33:17AM +0900, Roger Shimizu wrote:
> In order to support more linkstation devices, common part of current
> .dts file goes into .dtsi file. Some .dtsi are not with "orion5x" prefix
> because other kirkwood based linkstation devices are in this shape, and
> will be migrated some time later.
>   - orion5x-linkstation.dtsi
>   - linkstation-gpio-simple.dtsi
>   - linkstation-fan.dtsi

Hi Roger

I would prefer these have an mvebu- prefix. That then covers orion5x
and kirkwood.

Otherwise these look O.K.

	  Andrew
