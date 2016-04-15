From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Apr 2016 20:41:07 +0200
Subject: [PATCH V6 07/13] PCI: Provide common functions for ECAM mapping
In-Reply-To: <1460740008-19489-8-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-8-git-send-email-tn@semihalf.com>
Message-ID: <4434349.LMyShXzXEt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 19:06:42 Tomasz Nowicki wrote:
> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
> new file mode 100644
> index 0000000..34c0aba
> --- /dev/null
> +++ b/drivers/pci/ecam.h
> 

You are including this file from device drivers and potentially from ACPI 
code, so I think this needs to go into include/linux/pci*.h

	Arnd
