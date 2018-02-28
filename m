From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 28 Feb 2018 15:44:24 +0100
Subject: [RFC 0/4] Add support for the Gateworks System Controller
In-Reply-To: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20180228144424.GC12303@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 05:21:10PM -0800, Tim Harvey wrote:
> This series adds support for the Gateworks System Controller used on Gateworks
> Laguna, Ventana, and Newport product families.
> 
> The GSC is an MSP430 I2C slave controller whose firmware embeds the following
> features:
>  - I/O expander (16 GPIO's emulating a PCA955x)
>  - EEPROM (enumating AT24)
>  - RTC (enumating DS1672)

Hi Tim

Maybe it is in these patches, and i missed it....

How do these emulated devices work? Does the controller respond to
different addresses for these different emulated devices? Or is it an
I2c bus mux?

    Andrew
