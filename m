From: zonque@gmail.com (Daniel Mack)
Date: Mon, 24 Dec 2012 09:07:34 +0800
Subject: [PATCH v8 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <20121215072738.882313E0C08@localhost>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
 <1355481404-27695-6-git-send-email-zonque@gmail.com>
 <20121215072738.882313E0C08@localhost>
Message-ID: <50D7AAD6.1090705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2012 03:27 PM, Grant Likely wrote:
> On Fri, 14 Dec 2012 11:36:44 +0100, Daniel Mack <zonque@gmail.com> wrote:
>> This patch adds basic DT bindings for OMAP GPMC.
>>
>> The actual peripherals are instantiated from child nodes within the GPMC
>> node, and the only type of device that is currently supported is NAND.
>>
>> Code was added to parse the generic GPMC timing parameters and some
>> documentation with examples on how to use them.
>>
>> Successfully tested on an AM33xx board.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> For all patches in this series:
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks Grant!

Tony, could you apply these patches somewhere so others can base upon
them? As I said, I'm now travelling and can't continue my work, so I
would much like to know these series at a safe place :)


Again thanks to everyone,
Daniel
