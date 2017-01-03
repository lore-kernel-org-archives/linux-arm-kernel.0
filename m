From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 3 Jan 2017 23:11:19 +0900
Subject: [PATCH v3 2/3] DT: bingdings: power: reset: add linkstation-reset
 doc
In-Reply-To: <20170103131256.GB30197@lunn.ch>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-3-rogershimizu@gmail.com>
 <519e07d0-9b73-4445-ec5e-7ea2cbc1b814@gmail.com>
 <20170103131256.GB30197@lunn.ch>
Message-ID: <CAEQ9gEnKSDefeF_5WVRiu8pw5gnBWRoqYgMufoowox1ArD6e7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian, Andrew,

Thanks for your comments!

On Tue, Jan 3, 2017 at 10:12 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +
>> > +Required Properties:
>> > +- compatible: Should be "linkstation,power-off"
>> > +- reg: Address and length of the register set for UART1
>>
>> Humm, should we instead have a phandle to the uart1 node?
>
> Probably. Again, this is to do with copying the QNAP driver. I was
> young, new to device tree, and i just did a logical conversion of the
> existing code, and did not at the time understand phandles, etc.

Can you tell me where should I place this document?
or simply remove it?

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
