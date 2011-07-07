From: b32955@freescale.com (Huang Shijie)
Date: Thu, 7 Jul 2011 16:56:01 +0800
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support
	for	imx23/imx28
In-Reply-To: <201107011109.27206.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>	<201107010029.51965.arnd@arndb.de>
	<4E0D8C04.6010409@freescale.com> <201107011109.27206.arnd@arndb.de>
Message-ID: <4E1574A1.4050502@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> On Friday 01 July 2011 10:57:40 Huang Shijie wrote:
>>>> It's annoying, but it really saves some lines.
>>> It would save more lines if you introduce the macros globally and
>>> convert all existing resource definitions ;-)
>> The origin code did not use any macros.
>> Some one suggested me to use macros.
>> So i used the macros.
>>
>> Do i have to drop the macros?
> Can you find out who made the suggestion? Let's first reach consensus
> about how we want to do these things in the future.
http://www.spinics.net/lists/arm-kernel/msg121384.html

Thanks to your comments.


Best Regards
Huang Shijie
> My opinion is that we should not have macros like these in any platform
> specific code: If the macros are a good idea, we should define them
> globally and let everyone use the same macros. If we decide not to have
> them in global code, it would be even worse to have them in specific
> platforms.
>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
