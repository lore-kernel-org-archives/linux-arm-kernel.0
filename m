From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Mar 2016 12:31:13 +0800
Subject: [linux-sunxi] [PATCH v3 08/19] ARM: sun5i: Add DRAM gates
In-Reply-To: <1458751122-23976-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66AV8FT7VLs-WV=QD-w-zYrOqgE--Gubq=+hnEUaqUH6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 12:38 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The DRAM gates control whether the image / display devices on the SoC have
> access to the DRAM clock or not.
>
> Enable it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

I assume you'll add another version for A10s, or move the whole thing
to sun5i.dtsi later?
