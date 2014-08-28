From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Aug 2014 16:23:20 +0100
Subject: [PATCH V3 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
References: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140828152320.GN22580@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 03:45:01PM +0100, Steve Capper wrote:
> I would like to get this series into 3.18 as it fixes quite a big problem
> with THP on arm and arm64. This series is split into a core mm part, an
> arm part and an arm64 part.
> 
> Could somebody please take patch #1 (if it looks okay)?
> Russell, would you be happy with patches #2, #3, #4? (if we get #1 merged)
> Catalin, would you be happy taking patches #5, #6? (if we get #1 merged)

Pretty sure we're happy to take the arm64 bits once you've got the core
changes sorted out. Failing that, Catalin's acked them so they could go via
an mm tree if it's easier.

Will
