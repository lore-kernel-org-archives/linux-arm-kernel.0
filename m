From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 9 Jul 2016 10:26:49 +0200
Subject: [PATCH -next] clk: sunxi: Fix return value check in
 sun8i_a23_mbus_setup()
In-Reply-To: <1467807707-32039-1-git-send-email-weiyj_lk@163.com>
References: <1467807707-32039-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160709082649.GH4522@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 12:21:47PM +0000, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function of_io_request_and_map() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160709/24828146/attachment-0001.sig>
