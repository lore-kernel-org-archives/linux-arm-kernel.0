From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Mon, 21 Sep 2015 14:55:28 +0200
Subject: [PATCH 4/4] ARM64: dts: exynos5433: add jpeg node
In-Reply-To: <20150921084133.175b1bda@recife.lan>
References: <1442586060-23657-1-git-send-email-andrzej.p@samsung.com>
 <1442586060-23657-5-git-send-email-andrzej.p@samsung.com>
 <55FFD2D2.1010508@xs4all.nl> <55FFD4FF.6090306@samsung.com>
 <20150921084133.175b1bda@recife.lan>
Message-ID: <55FFFE40.8070801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

W dniu 21.09.2015 o 13:41, Mauro Carvalho Chehab pisze:

<snip>

>>>
>>> I think the media subsystem can take patches 1-3 and whoever does DT patches can
>>> take this patch, right?
>>>
>>
>> The cover letter explains that the series is rebased onto Mauro's
>> master with Kukjin's branch merged. The latter does contain
>> the exynos5433.dtsi. That said, yes, taking patches 1-3 in
>> media subsystem and leaving DT patch to someone else is the
>> way to go.
>
> I'm ok with such strategy, provided that the new driver builds fine with
> COMPILE_TEST without the need of the dtsi patch.
>

I've checked. It does compile with COMPILE_TEST.


> Please also notice that, if the driver uses MC, it has to wait for
> the MC next gen support to be merged,

No, it does not. It is a rather simple mem2mem device.

Sylwester has answered about camera support which is a different
topic.

Andrzej
