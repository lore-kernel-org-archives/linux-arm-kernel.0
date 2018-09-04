From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 4 Sep 2018 16:39:05 +0800
Subject: [PATCH 01/27] dt-bindings: sunxi-sram: add binding for Allwinner
 H6 SRAM C
In-Reply-To: <20180902072643.4917-2-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-2-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66V=7ArH0hssVZbBhD1v9P86oOXSh+1pY3e9xrzCHXBeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> The Allwinner H6 SoC's DE3 needs the SRAM C section being claimed in the
> system controller to work, like A64 DE2.
>
> As H6 and A64 system controller are quite similar, code is reused now,
> and the A64 fallback compatible string is added after the H6 compatible
> string.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> [fixed typo in compatible string]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
