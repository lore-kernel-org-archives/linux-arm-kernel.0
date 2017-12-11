From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Dec 2017 08:58:42 +0100
Subject: [PATCH 03/20] ARM: dts: aspeed-g4: Correct VUART IRQ number
In-Reply-To: <20171211050704.20621-4-joel@jms.id.au>
References: <20171211050704.20621-1-joel@jms.id.au>
 <20171211050704.20621-4-joel@jms.id.au>
Message-ID: <CAK8P3a2psgOYZEgO8O3H_xxpDTNd=ESJpSf4bs9kf0nPvKYqtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
> This should have always been 8.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

As this is a bugfix, should we backport it to stable kernels? When you
fix a bug,
I generally recommend including a 'Fixes' tag with the commit ID of the patch
that introduced the problem, and either a 'Cc: stable at vger.kernel.org' tag
if you want it backported, or an explanation in the changelog why it should
not get backported. This really helps Greg and the other stable maintainers
trying to make a decision what to backport and what not.

      Arnd
