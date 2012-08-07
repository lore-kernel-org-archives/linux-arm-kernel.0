From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Aug 2012 15:25:14 +0000
Subject: [PATCH V4 1/2] include/video: move fimd register headers from
 platform to include/video
In-Reply-To: <201208071428.56290.arnd@arndb.de>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
 <1344342872-7904-2-git-send-email-l.krishna@samsung.com>
 <201208071428.56290.arnd@arndb.de>
Message-ID: <201208071525.15032.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 August 2012, Arnd Bergmann wrote:
> On Tuesday 07 August 2012, Leela Krishna Amudala wrote:
> > 
> > This patch moves the contents from regs-fb-v4.h and regs-fb.h to
> > include/video/samsung_fimd.h. Also updates the header inclusion in
> > machine files and driver files accordingly.
> > 
> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> 
> You are missing an explanation here about why the file is moved.
> It does seem like a good idea but please say why you do this.
> 
> More importantly, I don't understany why you move regs-fb-v4.h
> but not regs-fb.h, which is included by the former.

Nevermind, I should have read your text better.

	Arnd
