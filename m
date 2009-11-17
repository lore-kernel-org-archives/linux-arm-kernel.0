From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Nov 2009 02:26:39 -0500
Subject: [PATCH 00/02] pxa: update WLED output current in da9034
In-Reply-To: <771cded00911050019r2e327457y8e6484155b2f281f@mail.gmail.com>
References: <771cded00911042356s3b7b2b5p34d25c19d45a21c3@mail.gmail.com>
	<771cded00911050019r2e327457y8e6484155b2f281f@mail.gmail.com>
Message-ID: <771cded00911162326t75f8d9a7g8a0691ff514ee2eb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2009 at 3:19 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Thu, Nov 5, 2009 at 2:56 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> Update WLED output current in order to drive LCD panel in saar
>> platform. Without this, LCD panel on saar can't be used directly.
>>
>> 0001-backlight-control-WLED-output-current-in-da9034.patch
>> 0002--ARM-pxa-set-default-WLED-output-current-in-saar.patch
>>
>
Hi Richard,

How do you think about this series patch? It's used to adjust output
current to bright up LCD panel.

Thanks
Haojian
