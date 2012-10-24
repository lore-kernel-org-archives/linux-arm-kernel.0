From: zonque@gmail.com (Daniel Mack)
Date: Thu, 25 Oct 2012 01:31:55 +0200
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <20121024232717.GD11928@atomide.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com>
 <20121024232717.GD11928@atomide.com>
Message-ID: <50887A6B.3050108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.10.2012 01:27, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [121022 12:57]:
>> This patch adds basic DT bindings for OMAP GPMC.
>>
>> The actual peripherals are instanciated from child nodes within the GPMC
>> node, and the only type of device that is currently supported is NAND.
>>
>> Code was added to parse the generic GPMC timing parameters and some
>> documentation with examples on how to use them.
>>
>> Successfully tested on an AM33xx board.
> 
> That's great, looks good to me. Please repost at least the
> binding patch with devicetree-discuss and Rob Herring cc:d
> so hopefully we'll get an ack for the binding.

Thanks for the review. I'll wait for feedback from Afzal next week and
then repost. Wanted to see first if that goes in the right direction at
all before bordering the DT people with binding details :)


Regards,
Daniel
