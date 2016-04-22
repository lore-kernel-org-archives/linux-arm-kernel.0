From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 21 Apr 2016 17:32:32 -0700
Subject: arm: soc fixes for v4.6
In-Reply-To: <57189CA2.3080401@gmail.com> (Matthias Brugger's message of "Thu,
 21 Apr 2016 11:25:54 +0200")
References: <570E1BD5.4090305@gmail.com> <57189CA2.3080401@gmail.com>
Message-ID: <7hr3dy4h5r.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias Brugger <matthias.bgg@gmail.com> writes:

> On 13/04/16 12:13, Matthias Brugger wrote:
>> Hi all,
>>
>> Please merge the following fix to end the boot regression for v4.6.
>>
>> Thanks,
>> Matthias
>>
>
> Kindly ping on this patch. Mediatek mt8173 does not boot with v4.6-rc4
> and needs this fix.
>

Oops, I merged this locally and even tested on mt8173-evb, but forgot to
push it out.  It's now in fixes and merged into for-next.

Thanks for the reminder,

Kevin
