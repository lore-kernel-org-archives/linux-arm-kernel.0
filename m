From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 4 Sep 2012 13:30:12 +0200
Subject: [PATCH] ARM: dts: OMAP4: Cleanup and move GIC outside of the
 OCP node
In-Reply-To: <CAMQu2gz7M7zWogTdCtR6K3n-9CPoLf7NO4a314WmKhN-BeXCiQ@mail.gmail.com>
References: <5044D8E5.5010705@ti.com>
 <CAMQu2gz7M7zWogTdCtR6K3n-9CPoLf7NO4a314WmKhN-BeXCiQ@mail.gmail.com>
Message-ID: <5045E644.9000904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2012 07:47 AM, Shilimkar, Santosh wrote:
> On Mon, Sep 3, 2012 at 9:20 AM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Remove a useless comment and move GIC controller outside
>> of the OCP node since it does use the MPU internal bus and
>> not the OCP.
>> This will not change the functionality but will reflect the
>> reality more accurately.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> ---
>>
> Make sense.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 

Thanks Santosh,

I'll update the patch with your ack are will add it after your series
for Tony to pull.

Thanks,
Benoit
