From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Aug 2013 12:15:28 +0200
Subject: [PATCH] ARM: u300: fix return value check in
 __u300_init_boardpower()
In-Reply-To: <CAPgLHd9cUJtF7WXmY4Sy+53MxjKJRe8RVNNtbfdYLzh6OwbNzg@mail.gmail.com>
References: <CAPgLHd9cUJtF7WXmY4Sy+53MxjKJRe8RVNNtbfdYLzh6OwbNzg@mail.gmail.com>
Message-ID: <CACRpkdZ9VBjPVOB9t4E6MJ80m_Mb78Fvp5sPk2Y0hOTQqu1wBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 4, 2013 at 3:51 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Patch applied.

Yours,
Linus Walleij
