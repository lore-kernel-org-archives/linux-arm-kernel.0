From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 10 Feb 2017 10:44:58 +0200
Subject: [PATCH v4 3/3] USB3/DWC3: Enable undefined length INCR burst type
In-Reply-To: <DB5PR0401MB1813965DDC8CC6CD0BD85980FE440@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <1484727138-3264-1-git-send-email-jerry.huang@nxp.com>
 <1484727138-3264-3-git-send-email-jerry.huang@nxp.com>
 <DB5PR0401MB1813965DDC8CC6CD0BD85980FE440@DB5PR0401MB1813.eurprd04.prod.outlook.com>
Message-ID: <87y3xeqvsl.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jerry Huang <jerry.huang@nxp.com> writes:
>> @@ struct dwc3 {
>>  	enum usb_phy_interface	hsphy_mode;
>> 
>>  	u32			fladj;
>> +	/*
>> +	 * For INCR burst type.
>> +	 * First field: for undefined length INCR burst type enable.
>> +	 * Second field: for INCRx burst type enable
>> +	 */
>> +	u32			incrx_type[2];
>>  	u32			irq_gadget;
>>  	u32			nr_scratch;
>>  	u32			u1u2;
>> --
>> 1.7.9.5
> Hi, Balbi and all guys,
> Any comment for these patches? Can they be accepted?

Rob had comments which you didn't reply yet. I cannot take this patchset
yet ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/8416f400/attachment.sig>
