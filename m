From: utx@penguin.cz (Stanislav Brabec)
Date: Mon, 08 Mar 2010 12:48:36 +0100
Subject: bit errors on spitz
In-Reply-To: <20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
Message-ID: <1268048916.6477.9.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyril Hrubis wrote:

> Well I've seen empty lines when editing file with vim

And I have seen:

- Unreproducible SIGSEGV of gcc (while Wi-Fi connection over CF card was
  running).
- Unreproducible SIGSEGV of opkg (downloading via Wi-Fi connection over
  CF card).
- Unreproducible SIGSEGV of rm (called from find command launched via
  ssh, networking via Wi-Fi connection over CF card).
  (Hint: Tasks above are HDD-intensive.)
- Lost blocks while copying from CF to SD.
- Lost blocks while copying from HDD to SD.
- Lost blocks while copying from CF to USB flash stick.
- And I see display noise while CF Wi-Fi card is active.

These problems appear in all kernels, at least since 2.6.26.

There is no note in the syslog.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
