From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Mon, 23 Nov 2009 21:02:37 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <ba4215e10911230907s78e4bdfftc8cba93857ae9fca@mail.gmail.com>
References: <20091117091713.GN14091@buzzloop.caiaq.de>	<20091117071744.GM14091@buzzloop.caiaq.de>	<20091110064900.GK14091@buzzloop.caiaq.de>	<20091104131500.GZ14091@buzzloop.caiaq.de>	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>	<OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>	<OF409EDC40.B7ED8C90-ON65257671.001667E7-65257671.001667F5@tcs.com>	<OF29677297.CAA27B00-ON65257671.002E6F4B-65257671.002E6F5C@tcs.com>	<OF8F8BC118.05889ED4-ON65257671.0041E186-65257671.0041E18F@tcs.com>	<20091117123935.GV14091@buzzloop.caiaq.de>
	<ba4215e10911230907s78e4bdfftc8cba93857ae9fca@mail.gmail.com>
Message-ID: <4B0AEA5D.6090500@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Martin Fuzzey wrote :
>> Assuming this is the reference hardware which you're running on, others
>> should be able to reproduce this error. Unfortunately I can't help here,
>> as I don't have access to any MX2 based hardware. Anyone else?
>>
> Mainline (2.6.32rc5) works fine on MX21 for me.
> 
> I also have a MX27 based board (Eukrea CPUMX27 module not a ADS) which
> worked fine on 2.6.30 (haven't tried since - could do so if no one
> else has a ADS handy).
> 
2.6.32-rc5 still works fine on CPUMX27 (i.MX27 + console on UART1 with 
TX/RX/RTS/CTS wired + OpenEmbedded generated rootfs).

How is wired your UART ? Is it using RTS/CTS ?
Is the iomux properly setup ?

Eric
