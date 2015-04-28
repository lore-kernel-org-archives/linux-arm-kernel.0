From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Tue, 28 Apr 2015 18:11:28 +0300
Subject: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
In-Reply-To: <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com>
 <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <553FA320.4040006@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series

Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

on Jetson-TK1.

I rebased my cpufreq series on top of this and everything's working well 
now. :)

Thanks,
Mikko.

On 04/17/2015 10:29 AM, Boris Brezillon wrote:
> ...
