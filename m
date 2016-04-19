From: oliver@schinagl.nl (Olliver Schinagl)
Date: Tue, 19 Apr 2016 14:21:11 +0200
Subject: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
In-Reply-To: <57160E06.1000806@cogentembedded.com>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
 <57160E06.1000806@cogentembedded.com>
Message-ID: <571622B7.2010202@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Sergei,

On 19-04-16 12:52, Sergei Shtylyov wrote:
> Hello.
>
> On 4/19/2016 10:12 AM, Olliver Schinagl wrote:
>
>> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc
>
>    scripts/checkpatch.pl now enforces certain commit citing style, the 
> commit summary should be specified too.
I used checkpatch from 4.6.0-rc2(or3) and did not notice it. But I'll 
add it to v2.
>
>> device as to having an broken HPI implementation. After talking some
>> with Hans, we now think it is actually the mmc controller that can be
>> broken and not support broken HPI's.
>>
>> This patch adds a new capability, mmc-broken-hpi, which allows us to
>> mark a broken hpi implementation on the host level.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> [...]
>
> MBR, Sergei
>
