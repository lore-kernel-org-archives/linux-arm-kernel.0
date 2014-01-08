From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 10:51:32 +0100
Subject: [PATCH 4/5] pinctrl: sirf: add pin group for USP0 with only RX or
 TX frame sync
In-Reply-To: <1388717966-11703-5-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
 <1388717966-11703-5-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdYsmhguywKqZmthOTEpKzOZ3RhXg8yMSEKpNxZ-VQNehw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 3:59 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Rongjun Ying <Rongjun.Ying@csr.com>
>
> USP0 has multiple functions, and has RX and TX frame sync signals,
> for some scenarios like audio PCM, we don't need both of them.
> so here we add two possibilities for USP0 only holding one of TX
> and RX frame sync.
>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Barry.Song@csr.com>

Patch applied.

Yours,
Linus Walleij
