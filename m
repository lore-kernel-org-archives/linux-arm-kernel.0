From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 10:49:13 +0100
Subject: [PATCH 1/5] pinctrl: sirf: add lost usp1_uart_nostreamctrl group
 for atlas6
In-Reply-To: <1388717966-11703-2-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
 <1388717966-11703-2-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdbi9C7DZGcFNVTfkMGvy3Vd8v8O5VeAXjr8C-oiJVg8PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 3:59 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Qipan Li <Qipan.Li@csr.com>
>
> commit af614b2301f0e304 adds lost USP-based UART pin groups for prima2,
> but missed usp1_uart_nostreamctrl group for atlas6, this patch fixes it.
>
> this makes USP(Universal Serial Ports) port1 can work as uart without
> stream ctrl.
>
> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied.

Yours,
Linus Walleij
