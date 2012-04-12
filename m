From: aneesh@ti.com (Aneesh V)
Date: Wed, 11 Apr 2012 19:57:59 -0700
Subject: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
 <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
Message-ID: <4F8644B7.1010705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 04/11/2012 07:44 PM, Paul Walmsley wrote:
> Cc Mark Greer, Mark Salter
>
> Hi Greg, Aneesh,
>
> On Sat, 17 Mar 2012, Aneesh V wrote:
>
>> Add a driver for the EMIF SDRAM controller used in TI SoCs
>>
>> EMIF is an SDRAM controller that supports, based on its revision,
>> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
>> for LPDDR2.
>
> Just checking to see what the current state of this series is.  Greg, are
> you considering this for merging, or are there remaining issues?  Aneesh,
> do you have any remaining issues to resolve with this set?

No. I don't have anything remaining. It's just that I was on vacation
for a while and couldn't find time for this after that. If Greg is fine
with this, I can rebase it and send one final version with
Reviewed-By's from Santosh and Benoit.

thanks,
Aneesh
