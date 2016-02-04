From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 4 Feb 2016 18:41:07 -0500
Subject: [PATCH v7 3/7] ARM: dts: imx: Add Advantech BA-16 Qseven module
In-Reply-To: <20160203144051.GQ8307@tiger>
References: <1454109558-22800-1-git-send-email-akshay.bhat@timesys.com>
 <1454109558-22800-4-git-send-email-akshay.bhat@timesys.com>
 <20160203144051.GQ8307@tiger>
Message-ID: <56B3E193.8090603@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/03/2016 09:40 AM, Shawn Guo wrote:
> On Fri, Jan 29, 2016 at 06:19:14PM -0500, Akshay Bhat wrote:
>> +&ssi1 {
>> +	fsl,mode = "i2s-master";
>
> In Documentation/devicetree/bindings/sound/fsl,ssi.txt, I do not see
> 'i2s-master' as a valid value for fsl,mode property.
>
> Shawn
>
Will fix this in the next rev (was copied over from an older kernel).

Is there a tool to find such errors (to help catch these errors before 
submitting it)?

Thanks,
Akshay

>> +	status = "okay";
>> +};
