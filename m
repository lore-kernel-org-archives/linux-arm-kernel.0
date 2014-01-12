From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 12 Jan 2014 20:34:10 +0100
Subject: [PATCH RFC 06/10] ARM: s3c64xx: pm: Add device tree based power
 domain instantiation
In-Reply-To: <20140112192910.GW29039@sirena.org.uk>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-7-git-send-email-tomasz.figa@gmail.com>
 <20140112192910.GW29039@sirena.org.uk>
Message-ID: <52D2EE32.5060709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.2014 20:29, Mark Brown wrote:
> On Sat, Jan 11, 2014 at 08:42:48PM +0100, Tomasz Figa wrote:
>
>> This patch adds support for registering power domains of S3C64xx SoCs
>> and binding devices to them using device tree.
>
>> +#ifdef CONFIG_OF
>> +static struct of_device_id s3c64xx_pd_matches[] = {
>> +	{ .compatible = "samsung,s3c6400-clock", },
>> +	{ .compatible = "samsung,s3c6410-clock", },
>> +	{ },
>>   };
>
> Looks like a rebasing issue?  Otherwise this looks nice.

Hmm, what's the problem here? Maybe I'm just blind, but I fail to see 
anything wrong (except that the array should be const...).

Thanks for reviewing this.

Best regards,
Tomasz
