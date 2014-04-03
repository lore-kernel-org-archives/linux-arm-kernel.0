From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Apr 2014 16:20:45 +0200
Subject: [PATCH] pinctrl: rockchip: fix offset of mux registers for rk3188
In-Reply-To: <CACRpkda9Lh19sfkxs3=dNWbg4FgkAtY2tJdMQik=TGs8wUkYfA@mail.gmail.com>
References: <1395700561-3793-1-git-send-email-b.galvani@gmail.com>
 <CACRpkda9Lh19sfkxs3=dNWbg4FgkAtY2tJdMQik=TGs8wUkYfA@mail.gmail.com>
Message-ID: <1810753.STDdFhitt6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. April 2014, 16:10:46 schrieb Linus Walleij:
> On Mon, Mar 24, 2014 at 11:36 PM, Beniamino Galvani <b.galvani@gmail.com> 
wrote:
> > The correct value of .mux_offset for rk3188 seems to be 0x60
> > instead of 0x68.
> > 
> > Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> 
> Patch applied to fixes with Heiko's Review tag and also
> copied some info from the conversation into the commit message.

small protest note

"Heikki adds:" - sounds somehow finish or swedish, but who is this guy? ;-)


But it doesn't really matter, so no need to roll it back

Heiko
