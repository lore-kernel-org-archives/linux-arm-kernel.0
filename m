From: richard.weinberger@gmail.com (Richard Weinberger)
Date: Tue, 2 Oct 2018 23:35:35 +0200
Subject: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
In-Reply-To: <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
Message-ID: <CAFLxGvwUP6+tfOr0NrM6vFs6NGepDz+MKPNnQWA+gO2k2mdPqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard,

On Tue, Oct 2, 2018 at 7:06 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> I guess qhasm means generated code, right?

Yes.
Please see: http://cr.yp.to/qhasm.html

It generates code from a q-file (the "template").
Actually it is a rather powerful tool, but as you noticed, sometimes
the code is not perfect.

-- 
Thanks,
//richard
