From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 12 Jun 2012 19:23:55 -0500
Subject: [PATCH V3 0/2] arm/dts: Add OMAP2420 SDP support
In-Reply-To: <4FD7DB2C.3090208@ti.com>
References: <1339546247-13865-1-git-send-email-jon-hunter@ti.com>
 <4FD7DB2C.3090208@ti.com>
Message-ID: <4FD7DD9B.40706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/12/2012 07:13 PM, Jon Hunter wrote:
> 
> On 06/12/2012 07:10 PM, Jon Hunter wrote:
>> This series fixes the OMAP2 interrupt controller binding and adds support for
>> the OMAP2420H4 board. I have verified that the kernel boots with device-tree
>> on this board.
> 
> Oops! Forgot to change SDP to H4 in the $SUBJECT. However, should be
> correct elsewhere.

Ok, scratch this version. I have forgotten to change the dts file too.
Sorry for all the noise, I shouldn't be trying to cram this in at the
end of the day!

Jon

>> This series is based upon the linux-omap master branch (3.5-rc1).
>>
>> V3: Rename OMAP2420 SDP to OMAP2420H4
>> V2: Correct typo in copyright date
>>
>> Jon Hunter (2):
>>   arm/dts: OMAP2: Add support for OMAP2420H4 Board
>>   arm/dts: OMAP2: Fix interrupt controller binding
>>
>>  arch/arm/boot/dts/omap2.dtsi       |    2 ++
>>  arch/arm/boot/dts/omap2420-sdp.dts |   20 ++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/omap2420-sdp.dts
>>
