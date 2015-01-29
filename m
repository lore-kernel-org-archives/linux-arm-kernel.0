From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 29 Jan 2015 15:35:14 +0100
Subject: [PATCH 1/2] ARM: zynq: Remove bogus value from 'bias-disable'
 property
In-Reply-To: <20150128154139.GK13057@xsjandreislx>
References: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
 <54C6DDE8.3000905@suse.de>
 <ce6e56872ab744a49612ef9bca07c73d@BN1AFFO11FD005.protection.gbl>
 <20150128154139.GK13057@xsjandreislx>
Message-ID: <4cef3a322a8543cdb8f9f57eafd7a09b@BL2FFO11FD014.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2015 04:41 PM, S?ren Brinkmann wrote:
> On Wed, 2015-01-28 at 03:21PM +0100, Michal Simek wrote:
>> On 01/27/2015 01:38 AM, Andreas F?rber wrote:
>>> Am 26.01.2015 um 20:49 schrieb Soren Brinkmann:
>>>> In one pinctrl node, a 'bias-disable' property is erroneously assigned a
>>>> value.
>>>>
>>>> Fixes: ARM: zynq: DT: Add pinctrl information
>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>
>>> Reviewed-by: Andreas F?rber <afaerber@suse.de>
>>>
>>> Andreas
>>>
>>
>> Applied both.
> 
> Thanks. Given how the branch looks now, you could squash 'ARM: zynq: DT:
> Remove bogus value from 'bias-disable' property' and 'ARM: zynq: DT: Add
> pinctrl information to USB nodes' into 'ARM: zynq: DT: Add pinctrl
> information'. Then we have it all in one patch and spare everybody the
> intermittent, partly broken commits.

That's not a problem. I have sent pull request with current state.

Thanks,
Michal
