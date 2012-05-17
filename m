From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 17 May 2012 14:36:16 +0800
Subject: [PATCH v7 3/3] MTD: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1337161217.24809.38.camel@sauron.fi.intel.com>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
 <1337093256-19117-4-git-send-email-josh.wu@atmel.com>
 <1337160353.24809.26.camel@sauron.fi.intel.com>
 <20403.29677.517067.528042@ipc1.ka-ro>
 <1337161217.24809.38.camel@sauron.fi.intel.com>
Message-ID: <4FB49C60.5030002@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

On 5/16/2012 5:40 PM, Artem Bityutskiy wrote:
> On Wed, 2012-05-16 at 11:31 +0200, Lothar Wa?mann wrote:
>>>> +		dev_warn(host->dev, "Only 2048 page size is currently " \
>>>> +			"supported for PMECC, rolling back to Software ECC\n");
>>> Why do you use backslashes?
>>>
>> message text should not be split across lines anyway to ease grepping
>> for the message.
> I think the consensus is that it is personal decision of the author. I
> am not trying to enforce this and I also split messages. In this case I
> was only wondering why that backslash is used? I never saw this before
> in the linux kernel.
>

oh, I add the backslash only because if without it, there should be a 
warning about message is splitting into two lines.

Now I think I will just keep the text message in one line. That will 
avoid any warnings. thanks.

Best Regards,
Josh Wu
