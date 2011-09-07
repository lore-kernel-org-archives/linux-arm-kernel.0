From: sbabic@denx.de (Stefano Babic)
Date: Wed, 07 Sep 2011 11:37:45 +0200
Subject: [PATCH V2] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <20110907093017.GA1912@pengutronix.de>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>
	<1315377931-15770-1-git-send-email-sbabic@denx.de>
	<20110907093017.GA1912@pengutronix.de>
Message-ID: <4E673B69.3030807@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2011 11:30 AM, Wolfram Sang wrote:
> On Wed, Sep 07, 2011 at 08:45:31AM +0200, Stefano Babic wrote:
>> Added initial support for DENX M28 module and M28EVK
>> board. Ethernet(FEC), SDHC, Display are supported.
>>
>> Signed-off-by: Stefano Babic <sbabic@denx.de>
> 
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> May I ask what bootloader do you use? The FSL-uboot or will there be mxs
> support in mainline u-boot?

Of course. I have tested the kernel using still the FSL-uboot, but
someone of us is porting the code to the actual u-boot mainline. Not yet
ready, but work is in progress, and patches should be submitted soon to
the mailing list.

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
