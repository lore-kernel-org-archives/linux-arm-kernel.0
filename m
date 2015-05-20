From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 17:21:05 +0200
Subject: [PATCH] ARM: lpc18xx: define low-level debug symbol for
 LPC18xx/43xx
In-Reply-To: <CAMuHMdU=MAr3nGE0cXH0X3a5eEqsw13b_WESYayoCABz4Z_YcQ@mail.gmail.com>
References: <1432061703-29104-1-git-send-email-manabian@gmail.com>
 <CAMuHMdU=MAr3nGE0cXH0X3a5eEqsw13b_WESYayoCABz4Z_YcQ@mail.gmail.com>
Message-ID: <3207536.veFSQqEDN9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 21:37:32 Geert Uytterhoeven wrote:
> Hi Joachim,
> 
> On Tue, May 19, 2015 at 8:55 PM, Joachim Eastwood <manabian@gmail.com> wrote:
> > Using a dedicated symbol for low-level debugging instead of the
> > arch symbol will make this platform play nice when enabled on a
> > kernel that supports multiple platforms.
> 
> Thanks a lot!
> 
> > Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> 

Applied to next/soc, with Geert's Ack. Thanks!

	Arnd
