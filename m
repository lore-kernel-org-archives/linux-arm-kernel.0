From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 10:53:19 +0100
Subject: [PATCH 0/5] ARM: dts: renesas: Remove skeleton.dtsi inclusion
In-Reply-To: <1477041370-22778-1-git-send-email-geert+renesas@glider.be>
References: <1477041370-22778-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161021095319.GC15372@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 11:16:05AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> As of commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
> as deprecated"), including skeleton.dtsi is deprecated.
> Hence this series removes its use for all Renesas 32-bit ARM SoCs.

Thanks for doing this! FWIW, for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
