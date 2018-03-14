From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 14 Mar 2018 16:34:31 -0700
Subject: [PATCH v2] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
In-Reply-To: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
References: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
Message-ID: <CA+55aFzgOZdW0c=L9MWGqUt1htiXZ2E2UVmc8HOrvGr3kqr4OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 12:29 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This reverts commit 864b75f9d6b0100bb24fdd9a20d156e7cda9b5ae.

Applied directly, since we already had two confirmations of it fixing
things for people.

Thanks,

                Linus
