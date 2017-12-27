From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 27 Dec 2017 12:13:39 -0800
Subject: [PATCH v6 2/8] module: use relative references for __ksymtab
 entries
In-Reply-To: <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
Message-ID: <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 12:11 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> I tried to keep the generic patches generic, so perhaps I should just
> put the arm64 vmlinux.lds.S change in a patch on its own?

I guess it doesn't matter, but regardless of where it gets introduced
I would like to see the explanation for where the heck that magical
".init.discard.text" comes from. It's definitely not obvious from the
patches, and is presumably some odd arm64 special case.

                Linus
