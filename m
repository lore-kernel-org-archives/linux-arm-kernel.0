From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 23 Aug 2011 21:45:09 +0200
Subject: Fwd: [RFC/PATCH v2 09/13] dt: omap4: add soc file for handling
	i2c controllers
In-Reply-To: <20110823151841.GB32698@manju-desktop>
References: <1314074021-25186-10-git-send-email-manjugk@ti.com>
	<4E537FA7.3050609@ti.com> <4E53AF9F.8070607@ti.com>
	<20110823151841.GB32698@manju-desktop>
Message-ID: <4E540345.1090004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/23/2011 5:18 PM, G, Manjunath Kondaiah wrote:
> On Tue, Aug 23, 2011 at 03:48:15PM +0200, Cousson, Benoit wrote:
>> From: G, Manjunath Kondaiah<manjugk@ti.com>
>>> To: devicetree-discuss at lists.ozlabs.org
>>> CC: linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org
>>>
>>>
>>> Add omap4 soc dts file for handling omap4 soc i2c
>>> controllers existing on l4-core bus.
>>
>> The subject and changelog is not accurate. You are doing at least 3 things:
>> Moving the OMAP4 SoC data from panda board file to a SoC specific
>> omap4.dtsi file.
>> Including the omap4.dtsi into panda.
>> Adding some i2c nodes.
>>
>> You should use at least two or three separated patches to avoid
>> in-accurate subject.
>
> As these changes are straight forward, I can update patch description with
> the required information instead of create too many patches.
>
> If you are too specific on splitting the patches, I am ok with that too.

I already fixed partially the OMAP4 patches as part of my upcoming OMAP4 
early devices DT migration. So I'll rebase your series on top of it.

I'll send you that tomorrow.

Benoit
