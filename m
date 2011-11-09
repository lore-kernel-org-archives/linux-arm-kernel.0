From: olof@lixom.net (Olof Johansson)
Date: Wed, 9 Nov 2011 08:01:22 -0800
Subject: [AT91 PULL] defconfig pullrequest
In-Reply-To: <20111109144126.GE31737@game.jcrosoft.org>
References: <20111102155803.GE7136@game.jcrosoft.org>
 <20111109144126.GE31737@game.jcrosoft.org>
Message-ID: <CAOesGMj_PGsShxUQGmBatiZLHYBGZj-8N+udJEpJv_zRv3pbkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 9, 2011 at 6:41 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> ? ? ? ?when do you pull this one?
>
> ? ? ? ?can it go to the 3.2?

Arnd is offline most of this week, so I'll reply.

The merge window is closed and only bug fixes should be sent upstream
at this time, so this should go into a 3.3-targeted branch now.

The pull request was sent halfway through the merge window, which to
be strict means that it was already too late. Next time, please make
sure your branches are staged in the arm-soc tree before the window
opens, ideally around -rc6 or -rc7 time frame.


-Olof
