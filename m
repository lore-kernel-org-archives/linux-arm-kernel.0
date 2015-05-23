From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 23 May 2015 12:58:59 +0900
Subject: [PATCH v6 00/13] ARM: dts: exynos4: labels for overriding nodes
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <555FFB03.8000607@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/15 17:09, Krzysztof Kozlowski wrote:
> Hi,
> 
Hi,

> 
> Changes since v5
> ================
> 1. Rebased on current Kukjin's for-next branch:
>    v4.1-rc3-34-gfcfae6b049cf
> 
> Changes since v4
> ================
> 1. Patch 1: Don't add labels in exynos4210-pinctrl.dtsi because
>    these are already defined in exynos4210.dtsi.
> 2. Patch 9: Add ack from Eduardo Valentin.
> 
> Changes since v3
> ================
> 1. New patches (12 and 13) for Exynos4412 Origen and Tiny4412.
> 2. Rebased on top of my DTS-for-next branch:
>    repo: https://github.com/krzk/linux/
>    tag: samsung-dt-for-next-4.2-2
> 
> Changes since v2
> ================
> 1. Fix typo in commit msg (lablels -> labels).
> 
> Changes since v1
> ================
> 1. Re-phrased the description (phandle->label). Suggested by Arnd.
> 
> Description
> ===========
> 
> The label-based notation reduces possible mistakes when overriding
> nodes by child DTSI and board files and reduces duplication
> of addresses.
> 
> The patchset refactors Exynos4 boards to use labels for overriding nodes.
> 
> Tested by comparison of decompiled DTB for each commit. The output DTB
> is the same.
> 
Thanks for your resending. Looks good to me and I'll sort them out in
this weekend.

- Kukjin
