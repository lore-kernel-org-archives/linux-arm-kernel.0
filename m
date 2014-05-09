From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 10 May 2014 02:59:15 +0400
Subject: [PATCH V2 2/2] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
In-Reply-To: <20140509050610.GB2624@katana>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
 <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
 <536C1945.1000601@cogentembedded.com> <20140509050610.GB2624@katana>
Message-ID: <536D5DC3.3070409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/09/2014 09:06 AM, Wolfram Sang wrote:

>>> +	eeprom at 50 {
>>> +		compatible = "renesas,24c02";

>>     This is not quite right: Renesas' part is called differently, and
>> you're carrying the other vendor's naming onto Renesas parts. I'd
>> just say "24c02" (which I'll do in the Henninger board patch).

> What about "generic"?

    I don't know, really. However, you're right in that there should be some 
vendor prefix -- I've just seen Documentation/devicetree/bindings/eeprom.txt.

WBR, Sergei
