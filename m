From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 May 2013 02:13:00 +0900
Subject: [PATCH 30/33] arch/arm/plat-samsung: don't check resource with
 devm_ioremap_resource
In-Reply-To: <20130520171118.GA5717@katana>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
 <1368702961-4325-31-git-send-email-wsa@the-dreams.de>
 <519A517F.5020003@samsung.com> <20130520171118.GA5717@katana>
Message-ID: <519A599C.2020702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/13 02:11, Wolfram Sang wrote:
> On Tue, May 21, 2013 at 01:38:23AM +0900, Kukjin Kim wrote:
>> On 05/16/13 20:15, Wolfram Sang wrote:
>>> devm_ioremap_resource does sanity checks on the given resource. No need to
>>> duplicate this in the driver.
>>>
>>> Signed-off-by: Wolfram Sang<wsa@the-dreams.de>
>>
>> Looks good to me, applied into Samsung tree.
>>
>> Wolfram, if you want to take this into your tree, let me know.
>
> It is already upstream :)
>
Oh, OK. Let me drop it in my tree ;-)

Thanks.

- Kukjin
