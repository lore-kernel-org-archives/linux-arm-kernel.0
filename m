From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 23 Aug 2015 12:00:08 +0200
Subject: Problems with device tree PMC clocks and threadirqs on at91
In-Reply-To: <loom.20150814T101121-265@post.gmane.org>
References: <555C8117.9010508@pcs.com>
 <loom.20150814T101121-265@post.gmane.org>
Message-ID: <20150823100008.GA13155@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/2015 at 08:28:01 +0000, baranikumar.venkatesan wrote :
> I'm getting the same issue as described above for Atmel SAMA5D31 board which
> is supported in kernel v3.18.9 with rt5+ patch. Also I've attempted your
> suggestion numbered 3(Do not wake up kthreadd_task in
> kthread_create_on_node() if kthreadd_task is NULL), but no luck. Could you
> help me if at all you have the solution?
> 

The following patch is the current workaround:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354024.html

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
