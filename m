From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 8 Apr 2013 17:18:46 +0530
Subject: [PATCH v2 1/3] media: davinci: vpss: enable vpss clocks
In-Reply-To: <CA+V-a8swx0LB0eK0bZwcuFhVCW2UB8Bvm3ebwMQifo=-TB6ASA@mail.gmail.com>
References: <1364903044-13752-1-git-send-email-prabhakar.csengg@gmail.com>
 <1364903044-13752-2-git-send-email-prabhakar.csengg@gmail.com>
 <51629B3D.4080905@ti.com>
 <CA+V-a8swx0LB0eK0bZwcuFhVCW2UB8Bvm3ebwMQifo=-TB6ASA@mail.gmail.com>
Message-ID: <5162AE9E.9030404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/8/2013 5:08 PM, Prabhakar Lad wrote:
> Sekhar,
> 
> On Mon, Apr 8, 2013 at 3:56 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On 4/2/2013 5:14 PM, Prabhakar lad wrote:
>>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>>
>>> By default the VPSS clocks were enabled in capture driver
>>> for davinci family which creates duplicates for dm355/dm365/dm644x.
>>> This patch adds support to enable the VPSS clocks in VPSS driver,
>>> which avoids duplication of code and also adding clock aliases.
>>>
>>> This patch uses PM runtime API to enable/disable instead common clock
>>> framework. con_ids for master and slave clocks of vpss is added in pm_domain
>>
>> Common clock framework in not (yet) used on DaVinci, so this is misleading.
>>
> OK, I'll make it 'This patch uses PM runtime API to enable/disable
> clock, instead
> of Davinci specific clock framework. con_ids for master and slave

may be just call it "DaVinci clock framework"

Thanks,
Sekhar
