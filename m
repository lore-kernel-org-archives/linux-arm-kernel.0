From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Feb 2014 10:43:45 +0100
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <20140226000940.GF1872@titan.lakedaemon.net>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
 <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
 <20140226000940.GF1872@titan.lakedaemon.net>
Message-ID: <CACRpkdYQa2BG_qxf5zY=7rks6O31ZF-BX0af3_u1MOgwfwxFSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 1:09 AM, Jason Cooper <jason@lakedaemon.net> wrote:

> Sebastian has now re-organized the branches as I asked, and I confirmed
> that the final result is the exact same as mine (diff is null).

Okay!

> Usually when I submit pull requests to arm-soc, they like to see the
> branches.  That way if there is an error in one of them, they just drop
> the one branch and the others remain.
>
> Would you like them the same way?  If so, I'll send the pulls to you
> tomorrow.

Send me one big branch with everything on it. Actually, I'd prefer
to pull it in, rebase and sign off each patch individually in my tree
if that is not causing you problems. That way it is visible that the
patches were funneled through pin control.

Yours,
Linus Walleij
