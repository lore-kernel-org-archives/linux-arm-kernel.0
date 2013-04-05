From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Apr 2013 23:10:48 +0200
Subject: [PATCH v2 0/9] rm: mvebu: Enable LPAE support for Armada XP SoCs
In-Reply-To: <201304052246.12731.arnd@arndb.de>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
 <201304052246.12731.arnd@arndb.de>
Message-ID: <515F3DD8.2040108@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 10:46 PM, Arnd Bergmann wrote:
> On Friday 05 April 2013, Gregory CLEMENT wrote:
>> The Armada XP SoCs have LPAE support. This is the second version patch
>> set whixh allow to run kernel on this SoCs with LPAE support.
>>
>> The biggest changes are the conversion of the device tree file to 64
>> bits in order to be able to use more than 4GB of memory (without this
>> the LPAE is pointless).
>>
> 
> The series looks good overall, I've commented on trivial details.

So there is still hope to have this patch set in 3.10 :)

> 
> Also, please use "ARM: mvebu: ..." in the subject rather than the lower-case
> version.

OK I will, but I saw a lot of 'arm' written in lower-case int the subject of emails
on the LAKML.
> 
> 	Arnd
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
