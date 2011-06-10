From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 9 Jun 2011 23:06:02 -0600
Subject: [PATCH] ARM: EXYNOS4: Fix incorrect mapping of gpio pull-up macro
	to register setting
In-Reply-To: <4DF14629.1070307@samsung.com>
References: <1307435689-15954-1-git-send-email-thomas.ab@samsung.com>
	<BANLkTi=YeOyK1WX61NtyprYdUyNmSo1sTw@mail.gmail.com>
	<20110607171030.GE17754@ponder.secretlab.ca>
	<4DF14629.1070307@samsung.com>
Message-ID: <BANLkTik1sK_B3KPU0vNi08HO0NFCE-7Rxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 9, 2011 at 4:16 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 06/07/11 10:10, Grant Likely wrote:
>>
>> On Tue, Jun 07, 2011 at 05:42:47PM +0900, Kyungmin Park wrote:
>>>
>>> On Tue, Jun 7, 2011 at 5:34 PM, Thomas Abraham<thomas.ab@samsung.com>
>>> ?wrote:
>
> (snip)
>
>> Applied, thanks.
>>
>> g.
>
> Hi Grant, sorry for late response.
>
> Could you please add my ack on this?
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Unfortunately that would require me to rebase my tree, which I'm
trying really hard to avoid.

g.
