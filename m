From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Feb 2012 10:59:23 +0100
Subject: RFC: what do we do with system controllers?
In-Reply-To: <20120228083833.GB18045@n2100.arm.linux.org.uk>
References: <CACRpkdY1W-RGE0JL4Sx5UcPY-EGieu8vo7H0fp9xyXtegpaaKw@mail.gmail.com>
 <20120228083833.GB18045@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaTJFL0A3caA4mNjxHTuXLC5u87OZ2yR=1ChiCFQL7c2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 9:38 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 28, 2012 at 06:48:12AM +0100, Linus Walleij wrote:
>> Mainly addressed to Greg but anyone is welcome to join the
>> discussion...
>>
>> Several ARM platforms have system controllers. In this I
>> include all custom terminology such as:
>>
>> - System Control
>> - Chip Controller
>> - Core Module control registers
>> - Power Reset Control Management Units
>> - Multimedia Communications Port
>
> Why do you include this? ?If you include this, you should include things
> like SSP/SPI ports, I2C and other such buses.

Mainly because it has these specific MCP controller oddity
functions:

mcp_set_telecom_divisor()
mcp_set_audio_divisor()

i.e. it has some "strangeness" of system controller type
(telecom? que?) But it's quite little and no big deal, drop
it off the list.

Thanks,
Linus Walleij
