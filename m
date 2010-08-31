From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 31 Aug 2010 10:59:09 -0400
Subject: [PATCH v1] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <87zkw2u956.fsf@deeprootsystems.com>
References: <4C7C52FD.6010608@criticallink.com>
	<87zkw2u956.fsf@deeprootsystems.com>
Message-ID: <4C7D18BD.9050708@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 8/31/2010 10:52 AM, Kevin Hilman wrote:
> Michael Williamson <michael.williamson@criticallink.com> writes:
>
>> This patch adds initial support for the MityDSP-L138 and MityDSP-1808 system
>> on Module (SOM) under the machine name "mityomapl138".  These SOMs are based
>> on the da850 davinci CPU architecture.  Information on these SOMs may be 
>> found at http://www.mitydsp.com.
>>
>> Basic support for the console UART, NAND, and EMAC (MII interface) is 
>> included in this patch. 
>>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>> ---
>> Patch is against 0a50e05b20f3c6af67656303bdb3661a2541ce03 of Kevin's tree 
>> (2.6.36-rc2).
>>
>> Changes since v0:
>>   1) Added CONFIG_REGULATOR_DUMMY to da8xx_omapl_defconfig to support
>>      DA8XX machines not providing voltage regulation.
>>   2) Added machine checks on da830/da850 EVM as well as MityDSP-L138 
>>      console init routines.
> These two should be a separate patch as it's a fix not directly related
> to your board support.
>

OK.  I'll separate them and resubmit.  Thanks for your help.

-Mike
