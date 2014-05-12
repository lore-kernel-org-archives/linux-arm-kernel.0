From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 May 2014 21:23:05 -0700
Subject: [PATCH 1/5] ARM: debug: Rename Hi3716 to HI5XHD2
In-Reply-To: <1399858236-29027-2-git-send-email-haojian.zhuang@linaro.org>
References: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
 <1399858236-29027-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140512042305.GA8896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 09:30:32AM +0800, Haojian Zhuang wrote:
> From: Haifeng Yan <yanhaifeng@gmail.com>
> 
> Rename Hisilicon HI3716 to HI5XHD2. And it relies on ARCH_HI5XHD2
> instead.

In general, we never rename platforms in the kernel. Why are you renaming in
this case? What is HI5XHD2? All of this should already have been part of the
patch description.


-Olof
