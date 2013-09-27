From: balajitk@ti.com (Balaji T K)
Date: Fri, 27 Sep 2013 20:07:48 +0530
Subject: [PATCH] ARM: dts: am335x-boneblack: move fixed regulator to board
 level
In-Reply-To: <20130920162154.GB18721@radagast>
References: <1379610764-758-1-git-send-email-nm@ti.com>
 <20130920162154.GB18721@radagast>
Message-ID: <5245983C.8090408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 September 2013 09:51 PM, Felipe Balbi wrote:
> On Thu, Sep 19, 2013 at 12:12:44PM -0500, Nishanth Menon wrote:
>> 3.3V fixed regulator does not belong to TPS node - as a result
>> the fixed regulator is never probed and MMC is continually deferred due
>> to lack of regulator.
>>
>> Move the fixed regulator to be at root of platform.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> Tested-by: Felipe Balbi <balbi@ti.com>
>

Tested-by: Balaji T K <balajitk@ti.com>
