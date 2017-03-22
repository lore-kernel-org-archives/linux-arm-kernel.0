From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 22 Mar 2017 11:33:15 +0800
Subject: [PATCH v3 03/11] ARM: dts: sun8i: sina33: add cpu-supply
In-Reply-To: <20170321153611.16228-4-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-4-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v67mihMMMqEpWSiuXXn6evXcquStGqQHRK2KdQzQ+EubNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds the cpu-supply DT property to the cpu0 DT node needed by
> the board to adapt the regulator voltage depending on the currently used
> OPP.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
