From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 20 May 2011 16:24:01 +0200
Subject: [PATCH 3/4] davinci: dm646x: remove the macros from the header
	to move to c file
In-Reply-To: <1305900721-3890-1-git-send-email-manjunath.hadli@ti.com>
References: <1305900721-3890-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <20110520142401.GV15292@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:42 Fri 20 May     , Manjunath Hadli wrote:
> move the register base addresses and offsets used only by dm646x
> platform file from platform header dm646x.h to dm646x.c as they
> are used only in the c file.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
I do not think it's a good idea to put the register mapping in the c file
evenif they are used only today in dm646x

Best Regards,
J.
