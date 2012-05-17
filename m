From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 May 2012 11:14:29 +0800
Subject: [PATCH] pinctrl: mxs: add gpio range support
In-Reply-To: <20120517025025.GI10347@shlinux2.ap.freescale.net>
References: <1337061374-24823-1-git-send-email-shawn.guo@linaro.org>
 <20120515115113.GC10347@shlinux2.ap.freescale.net>
 <20120517024715.GH3764@S2100-06.ap.freescale.net>
 <20120517025025.GI10347@shlinux2.ap.freescale.net>
Message-ID: <20120517031428.GI3764@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 10:50:26AM +0800, Dong Aisheng wrote:
> I'm wondering if dt forces user to define the same device sequentially.
> But if not, the driver may be better not assume how the device node are
> organized in dts, right?
> If we really want do like this, do we need to add some comments in binding doc?
> 
Yeah, will add a note in binding doc, though the example demonstrates
that already.

-- 
Regards,
Shawn
