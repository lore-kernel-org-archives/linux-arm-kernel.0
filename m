From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 13 Jun 2018 11:18:45 +0800
Subject: [PATCH v2 01/27] clk: sunxi-ng: r40: Add minimal rate for video
 PLLs
In-Reply-To: <20180612200036.21483-2-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-2-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66rUqqUrqmq09hHcGHF1buZieYmu1zOkUXZyyQPtyUZew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 4:00 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> According to documentation and experience with other similar SoCs, video
> PLLs don't work stable if their output frequency is set below 192 MHz.
>
> Because of that, set minimal rate to both R40 video PLLs to 192 MHz.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
