From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 21 Sep 2012 16:36:50 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <20120921150656.GG15609@n2100.arm.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
 <20120921153710.220adb92@bob.linux.org.uk>
 <20120921145803.GF15609@n2100.arm.linux.org.uk>
 <20120921160503.53736fee@pyramind.ukuu.org.uk>
 <20120921150656.GG15609@n2100.arm.linux.org.uk>
Message-ID: <20120921163650.0c5966e3@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sorry Alan, I don't think you really understand what I'm saying.

I'm taking about getting rid of the tty_termios_baud_rate() helper not
the uart_get_baud_rate() helper. The tty one has no real purpose any more
because we always set c_ospeed.

The uart layer one just needs some bug fixing I think.

Alan
