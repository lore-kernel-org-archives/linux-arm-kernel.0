From: zonque@gmail.com (Daniel Mack)
Date: Wed, 28 Nov 2012 17:59:47 +0100
Subject: [PATCH v5 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <20121128164606.GD5312@atomide.com>
References: <1354113509-7972-1-git-send-email-zonque@gmail.com>
 <1354113509-7972-5-git-send-email-zonque@gmail.com>
 <20121128164606.GD5312@atomide.com>
Message-ID: <50B64303.2020100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.11.2012 17:46, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [121128 06:40]:
>> This patch adds basic DT bindings for OMAP GPMC.
>>
>> The actual peripherals are instantiated from child nodes within the GPMC
>> node, and the only type of device that is currently supported is NAND.
>>
>> Code was added to parse the generic GPMC timing parameters and some
>> documentation with examples on how to use them.
>>
>> Successfully tested on an AM33xx board.
> 
> Please resend this with devicetree-discuss at lists.ozlabs.org and
> the people listed in MAINTAINERS in the cc:
> 
> Grant Likely <grant.likely@secretlab.ca>
> Rob Herring <rob.herring@calxeda.com>

Sorry - I picked the wrong entry from my history when sending. Resent now.


Daniel
