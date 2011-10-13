From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 13 Oct 2011 22:49:41 +0800
Subject: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <20111013152721.6abcbbdc@bob.linux.org.uk>
References: <1318487293-6963-1-git-send-email-Barry.Song@csr.com>
	<20111013105556.09d64d4d@bob.linux.org.uk>
	<CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
	<20111013152721.6abcbbdc@bob.linux.org.uk>
Message-ID: <CAGsJ_4z2nss7fEH2mKWEtzdSbDD6n+MnjrLVnFmxyXJQvZuaWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/13 Alan Cox <alan@linux.intel.com>:
>> >> +static struct console sirfsoc_uart_console = {
>> >> + ? ? .name ? ? ? ? ? = "ttyS",
>> >
>> > ttyS is 8250 devces. Pick a new name for your own.
>>
>> ok. most devices have names like ttySQ, ttySA, ttySG... since our SoC
>> is named SiRFprimaII, i'd like to have ttySI?
>
> If nobody else is using it for anything mainstream sure. Or ttySiRF0 ..
> etc might be more definitively unique
well. the later  in v2.

>
>
> Alan
>
-barry
