From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Feb 2016 16:14:01 +0000
Subject: [PATCH v3 00/10] Support for Cortex-M Prototyping System
In-Reply-To: <22011981.Gqc7zXAZ81@wuerfel>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <22011981.Gqc7zXAZ81@wuerfel>
Message-ID: <56C34AC9.8080509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 11:05, Arnd Bergmann wrote:
> On Tuesday 16 February 2016 10:08:05 Vladimir Murzin wrote:
>> Hi,
>>
>> This patch series provide the basic support for running ucLinux on V2M-MPS2
>> platform.
>>
>> With these patches applied ucLinux can be run on both HW and FVP models
>> with Cortex-M3/M4/M7 configurations.
> 
> Looks very nice overall now. I have mentioned a few details that I noticed
> but no show-stoppers.
> 
> Most important question for me is how this is going to be maintained
> in the long run. Can you add a patch to list the added files in
> MAINTAINERS?
> 
> My preference from the arm-soc perspective would be to get pull requests for
> this together with vexpress and juno through the existing maintainers
> (Liviu, Sudeep, Lorenzo), and have you send your patches to them. Does
> that work for you all?
> 

I'm quite happy with either way. I'm not targeting for 4.6, so we have
some time to sort it out.

Thanks
Vladimir

> 	Arnd
> 
> 
> 
