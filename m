From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Tue, 4 Dec 2012 22:20:04 +0100
Subject: [PATCH] [ARM] pxa/spitz: Disable usb port 1 and 3
In-Reply-To: <CAHod+GfAgcqE8Zt6hajLfb6pkReZkn-5KgOp4N9bMWuKD2vRgQ@mail.gmail.com>
References: <1354232481-32168-1-git-send-email-dromede@gmail.com>
 <CAMPhdO88Ydx7ghWK=Brzg=xn8YmFKdCyE3QNw9FaeZY+qNT8dg@mail.gmail.com>
 <CAHod+GfAgcqE8Zt6hajLfb6pkReZkn-5KgOp4N9bMWuKD2vRgQ@mail.gmail.com>
Message-ID: <CAHod+GeEbwsSxr2YH4ZBT2NX=hWWxO0=i7E90m95BWmkY08WmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 3, 2012 at 3:13 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> The port could be not routed to external, but used internally. I cannot
> remember the details of spitz as there isn't too much public detail around,
> just want to make sure no other devices are connected to port 1 and 3.

I'm pretty certain both are unused. Take a look at this:

http://www.penguin.cz/~utx/zaurus/www.iral.com/~albertr/linux/zaurus/wireless/

I also tested this change and i didn't notice that something was
broken or missing.

But if no power savings are to be gained from disabling these ports then
i guess we can leave them be.
