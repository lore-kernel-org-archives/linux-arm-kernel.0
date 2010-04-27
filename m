From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 27 Apr 2010 17:34:00 +0200
Subject: [PATCH 1/4] MMC: atmel-mci: fix two parameters swapped
In-Reply-To: <4BD70251.9060501@ru.mvista.com>
References: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
	<bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
	<4BD70251.9060501@ru.mvista.com>
Message-ID: <4BD703E8.4080307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/04/2010 17:27, Sergei Shtylyov :
> Hello.
> 
> Nicolas Ferre wrote:
> 
>> Two parameters were swapped in the calls to atmci_init_slot(). Two
>> parameters
>> were swapped in the calls to atmci_init_slot().
> 
>  The same sentence is repeated twice.
> 
>>  Their values
>>   
> 
>   ???

indeed! I reposted a new patch message.

Sorry for the noise.

Best regards,
-- 
Nicolas Ferre
