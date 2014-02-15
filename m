From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 15 Feb 2014 17:41:14 +0100
Subject: [PATCH] clk: at91: Fix memory leak
In-Reply-To: <52FF9760.8000800@overkiz.com>
References: <1392480848-17866-1-git-send-email-shc_work@mail.ru>
 <52FF9760.8000800@overkiz.com>
Message-ID: <20140215164114.GH2932@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/2014 at 17:35:44 +0100, Boris BREZILLON wrote :
> Hi Alexander,
> 
> Thanks for reporting and fixing this memory leak.
> 
> Unfortunately you're a bit late: this was already fixed, and I acked
> it ;-) (see
> http://www.gossamer-threads.com/lists/linux/kernel/1865947).
> 

Crap, I knew this looked familiar but I couldn't find it fixed in the
tree I'm working on :)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
