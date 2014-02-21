From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Feb 2014 17:02:52 -0800
Subject: linux-next: manual merge of the arm-soc tree with the arm-perf
 tree
In-Reply-To: <20140221115857.3ea3d7277d03c5b6b4d26488@canb.auug.org.au>
References: <20140221115857.3ea3d7277d03c5b6b4d26488@canb.auug.org.au>
Message-ID: <5306A5BC.8010409@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/14 16:58, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/boot/dts/qcom-msm8960-cdp.dts between commit a1d711938959 ("ARM:
> dts: msm: Add krait-pmu to platforms with Krait CPUs") from the arm-perf
> tree and commit cc60a1a4d47a ("ARM: dts: msm: split out msm8660 and
> msm8960 soc into dts include") from the arm-soc tree.
>
> I fixed it up (probably not the best way ... see below) and can carry the
> fix as necessary (no action is required).
>

It's good enough to be correct, but it would be better if the pmu node
went into the arch/arm/boot/dts/qcom-msm8960.dtsi file in the arm-soc tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
