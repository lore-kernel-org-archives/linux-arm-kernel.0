From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 11 Feb 2015 16:49:55 +0100
Subject: Overlapping regions in DT
In-Reply-To: <CABM=7kkcbj1Yxot=FEB3Z0OtWbJ=oDue76uSnAmZndhG=eJp=A@mail.gmail.com>
References: <488798996.225141.1423365437092.JavaMail.open-xchange@oxbaltgw06.schlund.de>
 <CABM=7kkcbj1Yxot=FEB3Z0OtWbJ=oDue76uSnAmZndhG=eJp=A@mail.gmail.com>
Message-ID: <54DB7A23.4000502@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tsahee,

Am 09.02.2015 um 09:22 schrieb Tsahee Zidenberg:
> syscon regmap is one possible way to access a register file from two
> different drivers without mapping it twice. But in that case you loose
> the name-per-register in devicetree. The devtree maps the general
> regfile, and the drivers know the offsets by themselves.
> Have a look here:
> Have a look: http://thread.gmane.org/gmane.linux.kernel/1352299

thanks for your suggestion. I'll give it a try.

Stefan
