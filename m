From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 06 Aug 2015 13:11:49 +0200
Subject: [PATCH v3 1/3] ARM: rockchip: rename osc_switch_to_32k variable
In-Reply-To: <2128609.Kb18M8K28F@diego>
References: <2128609.Kb18M8K28F@diego>
Message-ID: <39971049.CiZJKWC18V@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. August 2015, 00:50:39 schrieb Heiko St?bner:
> The variable name is misleading, as the deep suspend mode always switches
> the main supplying clock to the 32kHz source. Additionally the main
> oscillator remain running in some cases, which this var indicates.
> 
> So rename it to osc_disable to clarity.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied all 3 patches with Chris' and Doug's tags to my soc branch
