From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Nov 2011 09:12:41 -0200
Subject: 2.6.38 port not booting on i.MX53 SoM
In-Reply-To: <CAN=k24=fjYjz9ygUbwDFvCg6jNAvt4wPUZOufdytpDEx1bLqog@mail.gmail.com>
References: <CAN=k24ncTxDMXZzO1ef_+ETFiiqJZxtYSEOAKz3DiwCO8UKwcw@mail.gmail.com>
 <20111128100755.GI17668@pengutronix.de>
 <CAN=k24=fjYjz9ygUbwDFvCg6jNAvt4wPUZOufdytpDEx1bLqog@mail.gmail.com>
Message-ID: <CAOMZO5CSBds93wFiyTeTcbEZa_PzVuNtFfvcziRsh7p-Mu9=dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/29 Wayne Tams <wayne.tams@gmail.com>:

> I have followed your instructions and double checked serial bootargs
> by loading the 2.6.35 kernel; 2.6.35 loads ok displaying printks as it
> executes.
>
> However using the new 2.6.38 kernel, there are not any additional
> messages after enabling the debug settings you mentioned.

As Uwe explained this list is about mainline kernel.

I have a suggestion for you though: if you use FSL 2.6.38 you should
update your FSL U-boot also because there were some UART clock changes
from 2.6.35 to 2.6.38. Or use the mainline kernel instead ;-)

Regards,

Fabio Estevam
