From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 13 Dec 2012 14:44:43 +0100
Subject: sam9x5 one-wire driver not founding the device
In-Reply-To: <50C9A618.2090903@ronetix.at>
References: <50C9A618.2090903@ronetix.at>
Message-ID: <20121213134443.GC23971@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:55 Thu 13 Dec     , Martin Peevski wrote:
>     Hello, I'm working with sam9x35-cm on sam9x35-ek. Building Linux
> Kernel v.2.6.39+ and want to add W1 Dallas driver for communication
> with the sam9x35-cm DS2431 EEPROM. The driver is built but no device
> is found. Can you, please, help me?
> 
>     I'm trying to locate the source and find is the pin selected for
> communication routed correctly on the board but no success to date.
> Can you tell me where is defined in the source the pin used for W1
> communication?
> 
>     Isn't selected the correct pin when I make
> at91sam9x5ek_defconfig for the Kernal configuring?
we do not tru it under linux but work fine under barebox

Best Regards,
J.
