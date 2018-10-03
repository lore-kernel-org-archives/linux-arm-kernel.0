From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Wed, 3 Oct 2018 05:10:56 +0200
Subject: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
In-Reply-To: <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
Message-ID: <CAHmME9ojGATK+AcFLL2Fij_7XCW-=HBzjtkRqiitCH=p5=8KEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 6:59 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Could you elaborate on what qhasm is exactly? And, as with the other
> patches, I would prefer it if we could have your changes as a separate
> patch (although having the qhasm base would be preferred)

By the way, as of a few minutes ago, if you look in the development
tree at the commit called "zinc: Curve25519 ARM implementation", that
now shows the diffs to the original, as you requested. I'll probably
obsess over that a little bit more before v7, but if you see anything
gnarly there beforehand, I'd be happy to hear.

Jason
