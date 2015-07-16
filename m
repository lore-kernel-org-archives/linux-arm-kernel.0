From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 16 Jul 2015 09:52:55 -0700
Subject: [PATCH 5/5] PCI: Add host drivers for Cavium ThunderX processors.
In-Reply-To: <1437035476.27428.24.camel@tiscali.nl>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com>
 <1437035476.27428.24.camel@tiscali.nl>
Message-ID: <55A7E167.6040000@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2015 01:31 AM, Paul Bolle wrote:
> On wo, 2015-07-15 at 09:54 -0700, David Daney wrote:
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>
>> +config PCI_THUNDER_PEM
>> +	bool
>
> Do you expect other symbols to select this symbol in the future?

No, ...

> Because
> at this moment PCI_THUNDER_PEM is merely an alias for PCI_THUNDER.
>

... the next version of the patch will uncouple them.  They are separate 
drivers and should be selectable independently.

Thanks,
David Daney
