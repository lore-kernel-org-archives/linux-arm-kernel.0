From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 21 Jul 2012 20:19:00 +0400
Subject: [PATCHv2 2/2] ARM: vt8500: Add support for UHCI companion
 controller
In-Reply-To: <201207202210.28790.arnd@arndb.de>
References: <1342787373-2230-1-git-send-email-linux@prisktech.co.nz>
 <1342787373-2230-2-git-send-email-linux@prisktech.co.nz>
 <201207202210.28790.arnd@arndb.de>
Message-ID: <500AD674.9050206@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-07-2012 2:10, Arnd Bergmann wrote:

>> +static const struct of_device_id platform_uhci_ids[] = {
>> +	{ .compatible = "of-uhci", },
>> +	{}
>> +};

> The of- part is clearly meaningless in the binding that is about of
> devices. Using usb-uhci would be more appropriate I think, but maybe
> someone can come up with an even better name. Which consortium
> or company created uhci?

    UHCI is Intel's spec.

WBR, Sergei
