From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 3 Mar 2017 06:14:06 -0800
Subject: [PATCH 3/4] watchodg: sama5d4: simplify probe
In-Reply-To: <20170303092958.2phrxelq3xqojns7@piout.net>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
 <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
 <20170303090325.41b9ce64@free-electrons.com>
 <20170303092958.2phrxelq3xqojns7@piout.net>
Message-ID: <7abe4456-6c10-55bf-ead4-7379f23e7f6e@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 01:29 AM, Alexandre Belloni wrote:
> On 03/03/2017 at 09:03:25 +0100, Thomas Petazzoni wrote:
>> On Thu,  2 Mar 2017 18:31:13 +0100, Alexandre Belloni wrote:
>>
>>> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>>
>> Any reason to use irq_of_parse_and_map() over the more conventional
>> platform_get_irq() ?
>>
>
> No particular reason but I'm just removing the if (pdev->dev.of_node)
>
A function call change would (should) be a separate patch.

Guenter
