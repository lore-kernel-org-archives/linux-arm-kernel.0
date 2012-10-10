From: olof@lixom.net (Olof Johansson)
Date: Wed, 10 Oct 2012 09:11:36 -0700
Subject: [PATCH v2 0/6] ARM: EXYNOS: Add secure firmware support
In-Reply-To: <CAH9JG2V56eLCCX+9id1EWhKfZ-6qW-3O0j0mVpzOjz5S8QGQ7g@mail.gmail.com>
References: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
 <1647638.5fBfDOzz0u@amdc1227>
 <CAH9JG2V56eLCCX+9id1EWhKfZ-6qW-3O0j0mVpzOjz5S8QGQ7g@mail.gmail.com>
Message-ID: <20121010161136.GD582@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 11, 2012 at 12:35:54AM +0900, Kyungmin Park wrote:
> Hi Arnd or Olof,
> 
> Can you pick up for v3.7?
> 
> To Tomasz,
> Can you rebase it on the latest arm-soc tree?

This code should have been in arm-soc by the beginning of the merge window
(and in linux-next) to be merged for 3.7, but we will be happy to queue
it up for 3.8 once 3.7-rc1 is out. I have one outstanding comment on
the DT binding but the rest looks OK to me.

Tomasz, please rebase and send this to Kukjin so he can queue it up with other
Samsung code.


Thanks!

-Olof
