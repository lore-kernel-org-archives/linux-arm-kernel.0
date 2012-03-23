From: stigge@antcom.de (Roland Stigge)
Date: Fri, 23 Mar 2012 16:12:44 +0100
Subject: ioremap to a specific virtual address
In-Reply-To: <CAKON4Oz8465uJnv8R_TgCeju9UqG8MTTxVSC_tfS4mP40ARp1A@mail.gmail.com>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203230023060.24151@xanadu.home>
 <CAKON4Ox6sp5YMryr2jzOAqYNmJG9RyahLTusrHZ_jcNQ40DAfQ@mail.gmail.com>
 <201203231407.00686.arnd@arndb.de> <4F6C8E15.5050104@antcom.de>
 <CAKON4Oz8465uJnv8R_TgCeju9UqG8MTTxVSC_tfS4mP40ARp1A@mail.gmail.com>
Message-ID: <4F6C92EC.2050200@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/12 16:05, jonsmirl at gmail.com wrote:
> I've taken the 2.6.33 code and forward ported it to v3.3 in my git
> tree. I've been incorporating the patches posted to lpclinux.com.

Similar to what I did with lpc32xx. :-) NXP maintains lpc31xx and
lpc32xx at different repos, though.

> What about USB? There is code for a NXP variation on EHCI in the
> lpc31xx port, does the lpc32xx use the same EHCI block?

LPC32xx only has OHCI. For v3.4, I joined ohci-pnx4008 and ohci-lpc32xx
into ohci-nxp since only some transceiver I2C initialization was different.

Roland
