From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Apr 2018 14:29:51 +0530
Subject: [PATCH v2 2/2] ARM: dts: da850-lcdk: add unit name for memory node
In-Reply-To: <4843ee2b-bd62-a557-8d63-4a77374bcb2d@lechnology.com>
References: <20180418092408.2077-1-nsekhar@ti.com>
 <20180418092408.2077-3-nsekhar@ti.com>
 <4843ee2b-bd62-a557-8d63-4a77374bcb2d@lechnology.com>
Message-ID: <d4d50ced-c5f1-36e9-6cf7-e4098f7accd5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2018 08:50 PM, David Lechner wrote:
> On 04/18/2018 04:24 AM, Sekhar Nori wrote:
>> Add unit name for memory node to squash the W=1 warning:
>>
>> arch/arm/boot/dts/da850-lcdk.dtb: Warning (unit_address_vs_reg):
>> /memory: node has a reg or ranges property, but no unit name
>>
>> While at it, drop the device_type property from memory
>> node since its provided by da850.dtsi already.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>

Applied both to fixes.

Thanks,
Sekhar
