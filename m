From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 7 Sep 2012 10:37:25 +0200
Subject: [PATCH v7 0/3] arm/dts: Add device tree data for AM33XX devices
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA293E9@DBDE01.ent.ti.com>
References: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA293E9@DBDE01.ent.ti.com>
Message-ID: <5049B245.9080807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anil,

On 09/07/2012 07:30 AM, AnilKumar, Chimata wrote:
> On Thu, Sep 06, 2012 at 15:08:21, AnilKumar, Chimata wrote:
>> Add pinctrl and d_can device tree data to AM33XX family of devices.
>> First two patches add support for pinctrl DT data and third one
>> adds dcan DT data.
>>
>> Reason behind combining these patches is to apply cleanly on
>> linux-omap tree, because these are sequential patches.
>>Yes, 
>> These patches were tested on AM335x-Bone, AM335x-EVM and based
>> on linux-omap:master with this patch
>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg74393.html
>>
> 
> If there are no changes in this patch series ACK from
> reviewers (esp. Tony, koen and Marc) will help.

Yes, indeed. The series looks good to me, but it will be nice to get
some acks from people who commented previous revision.

Regards,
Benoit
