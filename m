From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2011 18:11:28 +0200
Subject: [PATCH 0/3] ARCH: CSR: basic PM suspend/resume support
In-Reply-To: <1315908393-362-1-git-send-email-Baohua.Song@csr.com>
References: <1315908393-362-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <201109131811.28241.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 September 2011, Barry Song wrote:
> 
> it was in thread "ARM: CSR: add rtciobrg and PM support" before. See:
> http://www.spinics.net/lists/arm-kernel/msg137375.html
> 
> Arnd has pulled rtciobrg into arm-soc next branch. PM should be another
> series.

Looks good to me, feel free to add my Acked-by to the patches, but
please add a meaningful changelog text to each patch first.
You can use some of the text that you put in the introductory mail.

In general, I expect even trivial patches to have a changelog of
one sentence and more text if the patch touches more code.

If nobody has other comments on the code, please send me a pull
request once that is done.

	Arnd
