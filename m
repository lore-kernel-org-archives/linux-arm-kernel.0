From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Oct 2015 17:20:51 +0800
Subject: [PATCH v4 3/5] clk: sunxi: pll2: Add A13 support
In-Reply-To: <1444682610-21482-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1444682610-21482-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444682610-21482-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67wc3E-eBU3KA0jDPMHy3H2chd872QZxcm5s6AsLrh6ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 4:43 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A13, unlike the A10 and A20, doesn't use a pass-through exception for
> the 0 value in the pre and post dividers, but increments all the values
> written in the register by one.
>
> Add an exception for both these cases to handle them nicely.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
