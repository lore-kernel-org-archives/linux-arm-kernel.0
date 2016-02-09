From: brijesh.singh@amd.com (Brijesh Singh)
Date: Tue, 9 Feb 2016 10:11:38 -0600
Subject: [PATCH V2 09/12] dtb: amd: Add KCS device tree node
In-Reply-To: <15181064.RzzsN4CWec@wuerfel>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <4018438.bPuTyoUuqf@wuerfel> <56BA0A2B.5000705@amd.com>
 <15181064.RzzsN4CWec@wuerfel>
Message-ID: <56BA0FBA.1010202@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/09/2016 10:00 AM, Arnd Bergmann wrote:
> 
> The important part for interrupt/reg/... names is that you must use exactly the
> names that are listed in the binding. If there is no name in there, it's better
> not to add the name property.
> 
> The other point is that "ipmi_kcs" is a name that is picked really badly, as it
> uses a '_' character while DT properties by convention use '-' between names,
> and the name of the IRQ is the same as the device itself, which is really
> not a useful way to disambiguate multiple interrupts in the same device, if
> someone ever adds another irq line.
> 

Sure we will drop the name field. Thanks.

> 	Arnd
> 
