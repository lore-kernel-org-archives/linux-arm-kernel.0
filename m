From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 17 Nov 2014 13:26:15 +0300
Subject: [PATCH v4] of: replace Asahi Kasei Corp venter prefix
In-Reply-To: <87y4ra8xac.wl%kuninori.morimoto.gx@renesas.com>
References: <878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>	<20140922130026.GK3290@leverpostej>	<CAMuHMdX22z97SbGS1HDiYfJ1PXxyEN2S8D7w4sr+4bUwD+mJZw@mail.gmail.com>	<20140922132743.GM3290@leverpostej>	<87y4rfhmgl.wl%kuninori.morimoto.gx@renesas.com>	<1415845309.4269.6.camel@perches.com>	<20141113025105.GA16652@verge.net.au>	<87vbmjhj00.wl%kuninori.morimoto.gx@renesas.com>	<20141113110740.GE3815@sirena.org.uk>	<87k32yd0bd.wl%kuninori.morimoto.gx@renesas.com>	<20141114093554.GC3810@ulmo>
 <87y4ra8xac.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <5469CD47.3040409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/17/2014 3:51 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    s/venter/vendor/ in the subject. Sorry for a late comment.

> Current vendor-prefixes.txt already has "ak" prefix for Asahi Kasei Corp
> by ae8c4209af2c(of: Add vendor prefix for Asahi Kasei Corp.)

> It went through the appropriate review process. But, almost all
> Asahi Kasei chip drivers are using "asahi-kasei" prefix today.
> (arch/arm/boot/dts/tegra20-seaboard.dts only is using "ak,ak8975",
>   but there are instances of "asahi-kasei,ak8975" in other dts files.
>   And drivers/iio/magnetometer/ak8975.c doesn't support "ak,ak8975")
> So, we made a mistake there.

> In addition, checkpatch.pl reports WARNING if it is using "asahi-kasei"
> prerfix in DT file.
> (DT compatible string vendor "asahi-kasei" appears un-documented)

> Marking it deprecated and warning with checkpatch is certainly
> preferable. So, this patch replace "ak" to "asahi-kasei" in
> vendor-prefixes.txt. (and fixup tegra20-seaboard)

> OTOH, Asahi Kasei is usually referred to as "AKM", but this patch
> doesn't care about it. Because no DT is using that today.

> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    One normally places ACKs after his own sign-off.

WBR, Sergei
