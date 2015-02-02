From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Mon, 2 Feb 2015 18:04:29 +0200
Subject: [PATCH v3 5/5] ARM: dts: Alpine platform devicetree
In-Reply-To: <20150202154149.GD21175@leverpostej>
References: <54cf5d8c.sl7aclyeuuh66jXt%tsahee@annapurnalabs.com>
 <20150202134051.GB21175@leverpostej>
 <CABM=7kmcPyxqah8Yek1PoSOzZarMh8eMFdakgz5k418FzMvc_g@mail.gmail.com>
 <20150202154149.GD21175@leverpostej>
Message-ID: <CABM=7kkTMLPemxyCcpFye99F9=84nW3KdXa7C6ynHYFBPeV8kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2015 at 17:41, Mark Rutland <mark.rutland@arm.com> wrote:

>> > Why is "simple-bus" on the end?
>> >
>>
>> Nodes that are used with "syscon_regmap_lookup_by_compatible" appear
>> both with and without compatibility to "simple-bus" in the
>> device-trees.
>> examples with: "fsl,imx6q-anatop", "xlnx,zynq-slcr"
>> examples without: "fsl,imx6q-iomuxc-gpr", "rockchip,rk3066-pmu"
>> Both ways work, I'm not if there is reasoning behind this difference
>> in current device-trees or which is the better example to follow. I
>> have no problem working either way. Is there a consensus on this?
>
> The "simple-bus" entry is wrong, and should be removed.
>
> In other cases it's also likely to be wrong, but I'd have to inspect
> them to be sure.
>
Will be fixed, then. Thank you!

Tsahee.
