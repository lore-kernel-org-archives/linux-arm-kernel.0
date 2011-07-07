From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 7 Jul 2011 13:28:42 -0500
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <alpine.LFD.2.00.1107070003410.14596@xanadu.home>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<ADE657CA350FB648AAC2C43247A983F001F383D6CD4D@AUSP01VMBX24.collaborationhost.net>
	<alpine.LFD.2.00.1107070003410.14596@xanadu.home>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383D6CF9D@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 06, 2011 9:04 PM, Nicolas Pitre wrote:
> On Wed, 6 Jul 2011, H Hartley Sweeten wrote:
>>> +	else if(mdesc->atag_offset)
>>> +		tags = PAGE_OFFSET + mdesc->atag_offset;
>> 
>> This results in a warning...
>> 
>> arch/arm/kernel/setup.c: In function 'setup_arch':
>> arch/arm/kernel/setup.c:820: warning: assignment makes pointer from integer without a cast
>
> Bleh.  Fixed, thanks.

Thanks.

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
