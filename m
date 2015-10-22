From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 21 Oct 2015 21:13:58 -0400
Subject: [PATCH] arm64: ftrace: function_graph: dump real return addr in
 call trace
In-Reply-To: <5628340F.5080902@huawei.com>
References: <1444911155-17480-1-git-send-email-huawei.libin@huawei.com>
 <6277407.jveniKQDxt@wuerfel> <20151015125133.GA29301@arm.com>
 <20151015101812.7cb6e917@gandalf.local.home>
 <20151020153227.GL11226@e104818-lin.cambridge.arm.com>
 <5628340F.5080902@huawei.com>
Message-ID: <20151021211358.7b8c31d3@grimm.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015 08:55:43 +0800
libin <huawei.libin@huawei.com> wrote:


> It still be needed, but it can be implemented in generic for all archs
> as Steve suggested.

I still recommend implementing it for arm64 as well, and then we can
look at what was done and how we can make it all generic.

-- Steve
