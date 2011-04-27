From: wg@grandegger.com (Wolfgang Grandegger)
Date: Wed, 27 Apr 2011 15:34:04 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <4DB81A12.1000006@grandegger.com>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>	<1303474267-6344-2-git-send-email-subhasish@mistralsolutions.com>	<4DB1A3B7.7060300@pengutronix.de>
	<4DB5D452.9050500@grandegger.com>	<46D523E49EFF489F9B088AE7B9CD7286@subhasishg>
	<4DB81A12.1000006@grandegger.com>
Message-ID: <4DB81B4C.9050404@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 03:28 PM, Wolfgang Grandegger wrote:
> On 04/27/2011 03:08 PM, Subhasish Ghosh wrote:
>>>
>>> - Use just *one* value per sysfs file
>>
>> SG - I felt adding entry for each mbx_id will clutter the sysfs.
>>        Is it ok to do that.
> 
> No, see:
> 
> http://lxr.linux.no/#linux+v2.6.38/Documentation/filesystems/sysfs.txt#L56

s/No/Yes/

Sorry for the confusion.

Wolfgang.
