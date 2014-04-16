From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 23:17:40 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr1JLq56x0VX+x5hnk9H4VjVUPSJOSUp2aEyoY99o+NbOQ@mail.gmail.com>
References: <CAA3XUr0+u9YCDhRx5xZgKC3GH1Y0Xiwh2731QWkWn0rGu7T2Gg@mail.gmail.com>
 <20140415.222423.744939892935802931.davem@davemloft.net>
 <CAA3XUr1JLq56x0VX+x5hnk9H4VjVUPSJOSUp2aEyoY99o+NbOQ@mail.gmail.com>
Message-ID: <20140415.231740.1803020760221209730.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>
Date: Tue, 15 Apr 2014 20:06:57 -0700

> But don't you think that writable and executable uprobes xol page is
> show stopper for this approach?

Not really.
