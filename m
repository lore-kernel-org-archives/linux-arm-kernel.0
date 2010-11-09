From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Nov 2010 16:03:31 +0100
Subject: [PATCH 6/6 v2] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <AANLkTikC9j2U3VUbEmfgH555Zq1sSO-hVtpg_k7hLFPS@mail.gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<201011080947.37522.arnd@arndb.de>
	<AANLkTikC9j2U3VUbEmfgH555Zq1sSO-hVtpg_k7hLFPS@mail.gmail.com>
Message-ID: <201011091603.31667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 November 2010, Alexey Charkov wrote:
> Quite frankly, I would say that all SoC framebuffer drivers are quite
> similar ;-) Register offsets, timing formats, accepted pixel formats,
> buffer alignment requirements are all different, so I do not really
> believe that there'd be much benefit from introducing another
> abstraction level. This is open to debate, of course.

Ok, I took a more detailed look at the code now. You're absolutely
right here.

	Arnd
