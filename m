From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 20 Nov 2014 09:28:49 +0100
Subject: [PATCHv4 01/10] arm: mvebu: fix vendor prefix typo in
 kirkwood-synology.dtsi
In-Reply-To: <7770322.bXz9M2IL1d@wuerfel> (Arnd Bergmann's message of "Thu, 20
 Nov 2014 08:35:43 +0100")
References: <cover.1416351425.git.arno@natisbad.org>
 <20141120015519.GA22670@titan.lakedaemon.net>
 <20141120050213.GB2596@lunn.ch> <7770322.bXz9M2IL1d@wuerfel>
Message-ID: <871toytgvy.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Arnd Bergmann <arnd@arndb.de> writes:

>> > Should the driver now support both variants for backward compatibility?
>> 
>> Hi Jason
>> 
>> This is an i2c device. i2c totally ignores the vendor. It is optional.
>> So there is no backward compatibility issues.
>> 
>
> This question keeps coming up, so I'd suggest explaining it in the
> patch changelog.

Granted ;-)

Cheers,

a+
