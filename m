From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 16 Apr 2013 10:55:13 +1000
Subject: [PATCH] clk: si5351: make clk-si5351 depend on CONFIG_OF
In-Reply-To: <1366009214-32234-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1366009214-32234-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130416105513.913219ac889b1db952876197@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Mon, 15 Apr 2013 09:00:14 +0200 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>
> Calling clk-si5351 driver non-OF ready was too early. This patch
> makes clk-si5351 depend on CONFIG_OF again, until things get sorted out.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reported-by: Stephen Rottweil <sfr@canb.auug.org.au>

My name is spelt "Rothwell" (as in the Cc: line below) :-(

> ---
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/08cfb712/attachment.sig>
