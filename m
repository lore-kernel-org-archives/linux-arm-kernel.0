From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 01 Oct 2015 21:14:53 +0200
Subject: [PATCH 2/4 RESEND] ARM: dts: berlin: change BG2Q's USB PHY
 compatible
In-Reply-To: <56073CB0.3060607@gmail.com>
References: <56073CB0.3060607@gmail.com>
Message-ID: <560D862D.1060804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.09.2015 02:47, Thomas Hebb wrote:
> Currently, BG2Q shares a compatible with BG2. This is incorrect, since
> BG2 and BG2Q use different USB PLL dividers. In reality, BG2Q shares a
> divider with BG2CD. Change BG2Q's USB PHY compatible string to reflect
> that.
>
> Signed-off-by: Thomas Hebb<tommyhebb@gmail.com>

Sorry, I have missed it. Now applied to berlin/fixes and tagged for
v4.2 stable series.

Sebastian
