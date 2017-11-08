From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 9 Nov 2017 00:22:36 +0800
Subject: [PATCH 1/3] ASoC: sun8i-codec: Invert Master / Slave condition
In-Reply-To: <20171108154710.16407-2-maxime.ripard@free-electrons.com>
References: <20171108154710.16407-1-maxime.ripard@free-electrons.com>
 <20171108154710.16407-2-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v658cy=vZkWDKQc-zCwfq+ezLqxctk=YwjidhsOzjDQY2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 8, 2017 at 11:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The current code had the condition backward when checking if the codec
> should be running in slave or master mode.
>
> Fix it, and make the comment a bit more readable.
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
