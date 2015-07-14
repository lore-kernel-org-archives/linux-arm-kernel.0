From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jul 2015 22:53:22 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <CACRpkdZ+_AJZhN7OmP=KXC+G0YrKuqOiWs9irjT1YFVYbab2Gw@mail.gmail.com>
References: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYQFrwJqZjW-A9txA=uaZqgXchSADVhPyxd7Z+5zOmF3g@mail.gmail.com>
 <CACRpkdZ+_AJZhN7OmP=KXC+G0YrKuqOiWs9irjT1YFVYbab2Gw@mail.gmail.com>
Message-ID: <2120032.PN20RpmoKe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 July 2015 10:21:51 Linus Walleij wrote:
> 
> Since the original code just defined all three serial ports
> for all boards by them including ste-dbx500.dtsi I first made
> the patch to that file, and then as you said it had to be done
> on a per-toplevel file, I did it in the individual DTS files instead.

I'm not following here. If you have boards that want port 1 to be
disabled, shouldn't you remove that alias?

	Arnd
