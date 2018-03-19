From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 13:41:34 -0700
Subject: [PATCH v4 4/6] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
In-Reply-To: <ad47a5c633fea2f75720dcd4b24fa6c41592d38b.1520327262.git.ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <ad47a5c633fea2f75720dcd4b24fa6c41592d38b.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <152149209476.242365.12761078522449253601@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ryder Lee (2018-03-06 01:09:29)
> The MediaTek audio hardware block that exposes functionalities that are
> handled by separate subsystems in the kernel.  These functions are all
> mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
> up with other functions within the same registers.
> 
> This patch modifies example to illustrate child nodes.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next
