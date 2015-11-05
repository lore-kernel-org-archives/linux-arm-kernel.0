From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 4 Nov 2015 23:02:00 -0800
Subject: [PATCH] reset: check return value of reset_controller_register()
In-Reply-To: <1446702896-1156-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446702896-1156-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151105070200.GV6436@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-11-05 at 02:54PM +0900, Masahiro Yamada wrote:
> Currently, reset_controller_register() always return 0, but it would
> be better to check its return code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
