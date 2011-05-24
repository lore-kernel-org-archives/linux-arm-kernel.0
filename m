From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 24 May 2011 07:32:20 +0200
Subject: [PATCH 3/4] davinci: dm646x: remove the macros from the header
	to move to c file
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D09B3A7@dbde02.ent.ti.com>
References: <1305900721-3890-1-git-send-email-manjunath.hadli@ti.com>
	<20110520142401.GV15292@game.jcrosoft.org>
	<B85A65D85D7EB246BE421B3FB0FBB593024D09B3A7@dbde02.ent.ti.com>
Message-ID: <20110524053220.GD863@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:04 Mon 23 May     , Nori, Sekhar wrote:
> 
> Hi Jean-Christophe,
> 
> On Fri, May 20, 2011 at 19:54:01, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 19:42 Fri 20 May     , Manjunath Hadli wrote:
> > > move the register base addresses and offsets used only by dm646x
> > > platform file from platform header dm646x.h to dm646x.c as they
> > > are used only in the c file.
> > > 
> > > Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> > I do not think it's a good idea to put the register mapping in the c file
> > evenif they are used only today in dm646x
> > 
> 
> Unless a definition is used across C files, it would be better to
> keep it local to the C file. Why treat base addresses and register
> offsets differently?
no difference the macro are nearly every time put in header not in C code

ditto of ifdef

Best Regards,
J.
