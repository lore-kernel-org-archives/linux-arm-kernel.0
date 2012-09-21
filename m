From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 21 Sep 2012 16:05:03 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <20120921145803.GF15609@n2100.arm.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
 <20120921153710.220adb92@bob.linux.org.uk>
 <20120921145803.GF15609@n2100.arm.linux.org.uk>
Message-ID: <20120921160503.53736fee@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Alan - the only issue that remains is handling the invalid baud rate
> situation - if left to individual drivers to do this, we will see them
> doing stuff (as was the case with this very patch - and was the case
> prior to serial_core) such as using dev_err() to print an error and
> merely returning from their set_termios function, or clamping to some
> speed and not feeding back to userspace what they're actually doing.

They've had years to adapt. It's time they got with the program or just
broke horribly.

Alan
