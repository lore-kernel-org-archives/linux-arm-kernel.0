From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 20 Oct 2015 19:29:55 +0200
Subject: [PATCH RFT] ARM: bcm2835: dt: fix memory of Raspberry Pi B+
In-Reply-To: <8737x5ncod.fsf@eliezer.anholt.net>
References: <1444942124-23122-1-git-send-email-stefan.wahren@i2se.com>
 <8737x5ncod.fsf@eliezer.anholt.net>
Message-ID: <56267A13.6090008@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.10.2015 um 10:53 schrieb Eric Anholt:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> Since the Raspberry Pi models differ in memory amount we
>> better define it at board level. After that we are able
>> to fix the memory node of the Raspberry Pi B+ .
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> [...]
>
> Seems like a good idea.  The closed firmware passes us an edited
> devicetree with good memory fields, but I don't think U-Boot is up to it
> if you chainload it.
>
> However, isn't the rpi-b-rev2 the 512MB variant of the rpi-b?
>

Unfortunately not. There are rev2 boards with 256 MB and with 512 MB RAM 
[1]. I'm not sure it is worth to create 2 dts files for both.

[1] - http://elinux.org/Board_revisions
