From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Jan 2015 15:09:56 -0800
Subject: [PATCH] ARM: dts: re-fromat AT91 part to match other entries
In-Reply-To: <1421160180-23452-1-git-send-email-nicolas.ferre@atmel.com>
References: <20150112224203.GL22090@quad.lixom.net>
 <1421160180-23452-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150113230956.GA15087@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 03:43:00PM +0100, Nicolas Ferre wrote:
> The entries are separated as ARM V4/V5 and ARM V7 as some other per-SoC config
> options may be removed in the near future.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Olof,
> 
> This is an attempt to match other ARM SoC families format.
> If you feel that the patch can be good, do not hesitate to take it yourself. I
> don't plan to integrate it in any of my pull-request so it can appear quickly in
> arm-soc and can be used by everyone.

Hi,

If you see what Peter did, he split up the rules per-SoC based on how
things were selectable in Kconfig. Since you seem to have the Kconfig
entries already, how about doing the same? That way the same information
w.r.t. SoC family that you have as comments isn't lost either.


-Olof
