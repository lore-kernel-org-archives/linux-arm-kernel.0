From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Nov 2010 22:24:46 +0800
Subject: [PATCH 01/11] ARM: pxa: redefine the cpu_is_pxa3xx
In-Reply-To: <AANLkTi=nve_2yF5djAcVVx4SN-fhzjoHUs=+7zqxc7Y_@mail.gmail.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTi=nve_2yF5djAcVVx4SN-fhzjoHUs=+7zqxc7Y_@mail.gmail.com>
Message-ID: <AANLkTikxVZjKmrqg6euUUMfzNhh2dH9hVCAu1bH5R01a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 4:00 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Nov 12, 2010 at 3:17 PM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
>> PXA300/PXA310/PXA320/PXA930/PXA935 are sharing one cpu family id.
>> It's a little confusion on cpu_is_pxa3xx().
>>
>> Now reduce the scope of cpu_is_pxa3xx(). Make it focusing on
>> PXA300/PXA310/PXA320. PXA930/PXA935 is coverd by cpu_is_pxa93x().
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>
> Applied.
>

Dropped as we discussed. Waiting for your new submission.
