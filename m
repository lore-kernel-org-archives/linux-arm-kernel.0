From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 17 Apr 2014 21:16:44 +0100
Subject: [PATCH 4/8] tty/serial: add generic serial earlycon
In-Reply-To: <CAL_JsqJwKQ_KuWWQNZHrMh8NwwiubB2jR+g-Y2n_dH4kJ5zVow@mail.gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <9368307.RXEGmQia1C@wuerfel>
 <CAL_JsqJh1R8wxReCvTfE7GecZa0vMaAqnGa0ZoRBMace9qtzvQ@mail.gmail.com>
 <21117957.8m9iUdR1VN@wuerfel>
 <CAL_JsqJwKQ_KuWWQNZHrMh8NwwiubB2jR+g-Y2n_dH4kJ5zVow@mail.gmail.com>
Message-ID: <20140417211644.39353c0d@www.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> At some point it was believed to be needed on the 8250 driver. Perhaps
> Alan can comment since the commit message tells us nothing:

Don't remember sorry - I guess at the time someone had ioremap on their
plaform acting as cached. It was a long time ago 8)
