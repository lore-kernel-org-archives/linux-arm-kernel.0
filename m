From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 12 May 2017 09:36:42 -0700
Subject: [PATCH] gpio: zynq: remove unneeded (void *) casts in
 of_match_table
In-Reply-To: <1494605925-6487-1-git-send-email-yamada.masahiro@socionext.com>
References: <1494605925-6487-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170512163641.ugh2fwqhrdhreeab@xsjsorenbubuntu.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-05-13 at 01:18:45 +0900, Masahiro Yamada wrote:
> of_device_id::data is an opaque pointer.  No explicit cast is needed.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
