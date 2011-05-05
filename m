From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 5 May 2011 10:55:21 +0200
Subject: PXA270 DIMM Module (NOR Flash) on v2.6.38
In-Reply-To: <BANLkTim_JuiFC4fxy2_XFdS6-FpzPTHg2w@mail.gmail.com>
References: <BANLkTin7EZb0src6sOA11yre-EQm+8cnVw@mail.gmail.com>
	<201105041731.02206.marek.vasut@gmail.com>
	<BANLkTim_JuiFC4fxy2_XFdS6-FpzPTHg2w@mail.gmail.com>
Message-ID: <201105051055.21695.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 05, 2011 10:44:14 AM Bas van Tiel wrote:
> Hi Marek,
> 
> I decoupled the JTAG interface and load the uImage into RAM via dm9000. Now
> it works at least with kernel booting, somehow there is an issue with the
> jtag lines and the kernel booting. I saw it a few years ago on an
> SH-proc with Lauterbach... Currently I'm running the latest git kernel

Congrats. I was loading the kernel into ram via JTAG too.

What module do you have btw ? Basic/Pro/Uber(?) ... I mean one with 64/128/256MB 
RAM ?

Cheers
> 
> greetings
> Bas
