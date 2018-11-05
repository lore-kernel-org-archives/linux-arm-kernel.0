From: john.garry@huawei.com (John Garry)
Date: Mon, 5 Nov 2018 14:58:21 +0000
Subject: [PATCH] arm64: defconfig: Enable some IPMI configs
In-Reply-To: <20181102182435.x46hvfgegxprksxq@localhost>
References: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
 <20181102182435.x46hvfgegxprksxq@localhost>
Message-ID: <97c2db1a-d7aa-aced-bd89-16527d35f376@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2018 18:24, Olof Johansson wrote:
> Hi John,
>
> On Fri, Oct 19, 2018 at 12:17:07AM +0800, John Garry wrote:
>> The arm64 port now runs on servers which use IPMI. This patch enables
>> relevant core configs to save manually enabling them when testing
>> mainline.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> I don't think these are required for booting to rootfs, so I'm applying
> the patch but switching them over to modules (=m) instead. Hope that's
> sufficient for your testing, let me know if it isn't.
>

It's ok.

Thanks,
John

>
> Thanks,
>
> -Olof
>
>
