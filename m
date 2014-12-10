From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 10 Dec 2014 08:46:57 -0800
Subject: [PATCH 2/4] PCI: iproc: Add Broadcom iProc PCIe driver
In-Reply-To: <9707535.Y78sV0TgX4@wuerfel>
References: <1418169871-19232-3-git-send-email-rjui@broadcom.com>
 <9707535.Y78sV0TgX4@wuerfel>
Message-ID: <54887901.8070501@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-12-10 03:31 AM, Arnd Bergmann wrote:
> On Tuesday 09 December 2014 16:04:29 Ray Jui wrote:
>> Add initial version of the Broadcom iProc PCIe driver. This driver
>> has been tested on NSP and Cygnus and is expected to work on all iProc
>> family of SoCs that deploys the same PCIe host controller
>>
>> The driver also supports MSI
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>
> The driver looks suspiciously like the one that Hauke already submitted a
> while ago for bcm53xx. Please come up with a merged driver that works for
> both.
Could you please be a little more specific.  What driver did "Hauke 
already submitted"?  I do not see any driver in the kernel you are 
talking about.
>
> Are you sure that iProc isn't based on the BCMA bus infrastructure after
> all? Even the physical address of your PCI host falls into the address
> range that is used for the internal BCMA bus on the other chips!
BCMA seems to be for MIPS architectures.  It seems to be quite specific 
to those architectures using BCMA.  I see no use of it in bcm53xx code?
>
> 	Arnd
>
