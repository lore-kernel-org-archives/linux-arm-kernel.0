From: alan@linux.intel.com (Alan Cox)
Date: Thu, 13 Oct 2011 15:27:21 +0100
Subject: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
References: <1318487293-6963-1-git-send-email-Barry.Song@csr.com>
	<20111013105556.09d64d4d@bob.linux.org.uk>
	<CAGsJ_4zvc=HaVURyARV0k6m7btfMjQo1frqmJa-OtE--eyCsFA@mail.gmail.com>
Message-ID: <20111013152721.6abcbbdc@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +static struct console sirfsoc_uart_console = {
> >> + ? ? .name ? ? ? ? ? = "ttyS",
> >
> > ttyS is 8250 devces. Pick a new name for your own.
> 
> ok. most devices have names like ttySQ, ttySA, ttySG... since our SoC
> is named SiRFprimaII, i'd like to have ttySI?

If nobody else is using it for anything mainstream sure. Or ttySiRF0 ..
etc might be more definitively unique


Alan
