From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 23:22:29 +0200
Subject: [PATCH 01/26] ARM: nomadik: move mtu setup to clocksource init
In-Reply-To: <523CBA5F.60901@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <523CBA5F.60901@gmail.com>
Message-ID: <CACRpkdZDoBDrF0A4KFUeJxw0cZzL8dLcRTFzhxY0ZRKET8T7bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 11:13 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> Linus,
>
> looking at the fix you posted at [1], can I assume that the above it
> redundant and can be removed?
>
> [1] http://marc.info/?l=linux-arm-kernel&m=137910161418706&w=2

I think so, post a version doing that and I'll test it along with my other
patch.

If it blows up I'll notice :-)

Yours,
Linus Walleij
