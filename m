From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 19 Apr 2016 16:23:40 +0300
Subject: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
In-Reply-To: <571622B7.2010202@schinagl.nl>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
 <57160E06.1000806@cogentembedded.com> <571622B7.2010202@schinagl.nl>
Message-ID: <5716315C.7070001@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2016 3:21 PM, Olliver Schinagl wrote:

>>> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc
>>
>>    scripts/checkpatch.pl now enforces certain commit citing style, the
>> commit summary should be specified too.

> I used checkpatch from 4.6.0-rc2(or3) and did not notice it. But I'll add it
> to v2.

    Maybe it just didn't recognize your commit citing? Anyway, the format is 
the same as for the "Fixes:" tag.

>>> device as to having an broken HPI implementation. After talking some
>>> with Hans, we now think it is actually the mmc controller that can be
>>> broken and not support broken HPI's.
>>>
>>> This patch adds a new capability, mmc-broken-hpi, which allows us to
>>> mark a broken hpi implementation on the host level.
>>>
>>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> [...]

MBR, Sergei
