From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 08 Mar 2015 23:19:36 +0100
Subject: [PATCH v3 5/9] mtd: pxa3xx_nand: add support for the Marvell
 Berlin nand controller
In-Reply-To: <54FCAF6C.7010902@free-electrons.com> (Ezequiel Garcia's message
 of "Sun, 08 Mar 2015 17:22:04 -0300")
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425555085-29531-6-git-send-email-antoine.tenart@free-electrons.com>
 <54FA6DFC.1070904@free-electrons.com> <87oao3xvh8.fsf@free.fr>
 <54FCAF6C.7010902@free-electrons.com>
Message-ID: <87ioebxhc7.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

>> I think you'll kill the zylonite board, and I'll nack it if that's the case. At
>> least that's what happened when I tried to use onfi default values last time in
>> barebox development.
>> 
>> I can test your changes, but if the specific zylonite nand (ie. nand id 0xba20,
>> ie. pxa310 embedded flash) gets broken, I'm against the removal of the legacy
>> timings removal.
>>
>
> I'm not speaking of any timing params here, but about the flash
> identification.
>
> Which flash do you have there?
The one with 0xba20 id as I said, which is AFAIK a Numonyx NAND02GR4B2C.

And of course a "READ_ID(ONFI)" doesn't work (tested)... sic ... as showed in :
http://www.linux-mtd.infradead.org/nand-data/nanddata.html

Cheers.

-- 
Robert
