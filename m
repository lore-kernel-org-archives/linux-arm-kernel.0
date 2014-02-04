From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Feb 2014 21:49:36 +0100
Subject: [PATCH 1/2] pinctrl: sirf: add pin group for USP0 with only RX or
 TX frame sync for atlas6
In-Reply-To: <1391061264-2162-1-git-send-email-21cnbao@gmail.com>
References: <1391061264-2162-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdaYWhfYe8+pOh-3CSMf=hF6fjC71JR530HjVF8eXzV7Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 6:54 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Rongjun Ying <rongjun.ying@csr.com>
>
> USP0 has multiple functions, and has RX and TX frame sync signals, for some scenarios
> like audio PCM, we don't need both of them. so here we add two possibilities for USP0
> only holding one of TX and RX frame sync.
>
> commit 8385af02bad only added this group for prima2, and missed atlas6. her this patch
> fixes it.
>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied. Altered the commit message a bit.

Yours,
Linus Walleij
