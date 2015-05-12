From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 May 2015 12:28:04 -0500
Subject: next-20150511 / omap2-mcspi: regression for sdp4430 boot
In-Reply-To: <20150512172253.GA18821@deathray>
References: <5550DDCB.8010303@ti.com> <20150511170742.GA6616@deathray>
 <5550F47C.1030902@ti.com> <20150511183032.GA8085@deathray>
 <5550FC38.6020801@ti.com> <20150511201633.GA31117@deathray>
 <555235CC.9040706@ti.com> <20150512172253.GA18821@deathray>
Message-ID: <55523824.2090001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2015 12:22 PM, Michael Welling wrote:
> On Tue, May 12, 2015 at 12:18:04PM -0500, Nishanth Menon wrote:
>> On 05/11/2015 03:16 PM, Michael Welling wrote:
>> [...]
>>> Okay I have another patch that appears to fix the issue on my board.
>>>
>>> Please test the attached patch and see if it fixes the issue on your board.
>>>
>>> If it does, I will send it upstream.
>>
>> Tested on: 20150512 http://paste.ubuntu.org.cn/2600365
>> Works :). Thanks for rootcausing and providing a fix.
> 
> Phew.
> 
> Okay this patch or a revision of it should land upstream soon.

please feel free to cc linux-omap at vger.kernel.org -> one of us will
try and provide a tested-by to the formal patch -> might be good to
add a "Fixes:" tag as well if Mark wishes to see something to the effect.


-- 
Regards,
Nishanth Menon
