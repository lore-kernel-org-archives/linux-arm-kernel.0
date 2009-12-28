From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 21:34:10 +0800
Subject: [PATCH 3/4] pxa/zeus: Relax memory timings on Zeus ethernet ports
In-Reply-To: <1261859150-17335-4-git-send-email-maz@misterjones.org>
References: <1261859150-17335-1-git-send-email-maz@misterjones.org>
	<1261859150-17335-2-git-send-email-maz@misterjones.org>
	<1261859150-17335-3-git-send-email-maz@misterjones.org>
	<1261859150-17335-4-git-send-email-maz@misterjones.org>
Message-ID: <f17812d70912280534y1fa6004bx25c186c223fd49b0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 27, 2009 at 4:25 AM, Marc Zyngier <maz@misterjones.org> wrote:
> DM9000s on Zeus sometime fail under heavy load.
> Relaxing the timings a bit seems to be of a great help.
>
> Signed-off-by: Marc Zyngier <maz@misterjones.org>

Applied with removal of trailing whitespace and a typo of additional ";" in
the #define statement.
