From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 05:34:38 -0700
Subject: [PATCH 0/2] STM32: Fixes for 4.19 cycle
In-Reply-To: <1537461257-2940-1-git-send-email-alexandre.torgue@st.com>
References: <1537461257-2940-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <20180923123438.kyvxpeqq6q6xo6cs@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Thu, Sep 20, 2018 at 06:34:15PM +0200, Alexandre Torgue wrote:
> Hi Arnd, olof and Kevin
> 
> Those 2 patches fixe the same issue on 4.19-rc: a bad usage of the mdma
> binding inside stm32mp157c.dts file. Can you please add them as fixe for 4.19 ?

The patches only mention removing unused property contents, not what the bug is
that it fixes (or if it's even causing any problems). Care you clarify?

If it's just fixing inaccurate DT that isn't used, then it's not something we
urgently need to fix in 4.19 and it can wait for 4.20.


Thanks,


-Olof
