From: rogerq@ti.com (Roger Quadros)
Date: Wed, 6 Feb 2013 10:56:39 +0200
Subject: [PATCH 09/13] mfd: omap-usb-host: Add device tree support and
 binding information
In-Reply-To: <20130205161141.GD26842@e106331-lin.cambridge.arm.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-10-git-send-email-rogerq@ti.com>
 <20130205142049.GC26842@e106331-lin.cambridge.arm.com>
 <51111A41.4050607@ti.com>
 <20130205161141.GD26842@e106331-lin.cambridge.arm.com>
Message-ID: <51121AC7.6070107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 06:11 PM, Mark Rutland wrote:
> [...]
> 
>>>> +
>>>> +- single_ulpi_bypass: Must be present if the controller contains a single
>>>> +  ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
>>>
>>> Again it would be nicer to have '-' rather than '_' here. It might be worth
>>> prefixing this "ti,".
>>
>> Is prefixing with "ti" really required? how does it better?
> 
> I thought single-ulpi-bypass sounded rather generic, but it probably is
> specific enough as-is. I don't know enough about USB hardware to have strong
> feelings either way.
> 

Yes, it is specific to the TI silicon. I'll leave it as it is then.

cheers,
-roger
