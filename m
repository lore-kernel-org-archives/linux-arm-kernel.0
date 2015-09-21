From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Mon, 21 Sep 2015 11:59:27 +0200
Subject: [PATCH 4/4] ARM64: dts: exynos5433: add jpeg node
In-Reply-To: <55FFD2D2.1010508@xs4all.nl>
References: <1442586060-23657-1-git-send-email-andrzej.p@samsung.com>
 <1442586060-23657-5-git-send-email-andrzej.p@samsung.com>
 <55FFD2D2.1010508@xs4all.nl>
Message-ID: <55FFD4FF.6090306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

W dniu 21.09.2015 o 11:50, Hans Verkuil pisze:
> On 18-09-15 16:21, Andrzej Pietrasiewicz wrote:
>> From: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> Add Exynos 5433 jpeg h/w codec node.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
>> ---
>>   arch/arm64/boot/dts/exynos/exynos5433.dtsi | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>
> This dtsi file doesn't exist in the media-git tree. What is the story here?
>
> Should this go through a different subsystem?
>
> I think the media subsystem can take patches 1-3 and whoever does DT patches can
> take this patch, right?
>

The cover letter explains that the series is rebased onto Mauro's
master with Kukjin's branch merged. The latter does contain
the exynos5433.dtsi. That said, yes, taking patches 1-3 in
media subsystem and leaving DT patch to someone else is the
way to go.

Andrzej
