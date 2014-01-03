From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 3 Jan 2014 17:51:36 +0800
Subject: [PATCH 0/6] arm: sunxi: rename DT clock node names to clk@N
In-Reply-To: <1388736111-10103-1-git-send-email-wens@csie.org>
References: <1388736111-10103-1-git-send-email-wens@csie.org>
Message-ID: <CAGb2v64uYUkf8n3NRzSW9t4do5i3mUDUAaLW35RMm9_1hmjn5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 3, 2014 at 4:01 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This patch series renames the clock nodes in sunxi dts to conform
> to device tree naming conventions, i.e. clk at N. Dummy clocks that
> will be renamed/removed later, or clocks sharing registers are not
> renamed.

This patch series breaks pll5 and pll6.
Please do not apply. I will put out a v2 later.


ChenYu
