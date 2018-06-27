From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 27 Jun 2018 17:05:14 +0200
Subject: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
In-Reply-To: <20180627145713.uao2gr5kknk2cypk@holly.lan>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
 <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
 <20180626164117.GA5241@Mani-XPS-13-9360>
 <20180627145713.uao2gr5kknk2cypk@holly.lan>
Message-ID: <71176a0c-dd23-2ca6-7698-9612e4ed6392@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.06.2018 um 16:57 schrieb Daniel Thompson:
> On Tue, Jun 26, 2018 at 10:11:17PM +0530, Manivannan Sadhasivam wrote:
>>> Question: Should it still be GPL-2.0+ or the new GPL-2.0-or-later?
>>
>> I think GPL-2.0+ is fine.
> 
> So... when I saw this I did wonder why one would knowly choose to use a
> deprecated license identifier (https://spdx.org/licenses/ ).
> 
> However running `git diff v4.17..v4.18-rc1` through some filters does
> indicate that GPL-2.0+ is the more popular choice by 256 to 0! Doesn't
> mean you couldn't break the mould though ;-).

The kernel.org documentation does not mention the new ones yet.

I checked under LICENSES/ - preferred/GPL-2.0.txt actually lists both
identifiers, and checkpatch.pl did not complain about either.

So for my personal patches I'll be going with the new identifier, unless
I hear of reasons not to.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
