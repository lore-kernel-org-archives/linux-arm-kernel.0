From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Nov 2013 18:40:58 +0100
Subject: [PATCH -next] tree-wide: add missing clk_disable_unprepare() on
 error in wmt_i2c_reset_hardware()
In-Reply-To: <CAPgLHd-j19gkcuBEVUm5EkUkqXbqZBZ9i74p1WXth89rEaDpJw@mail.gmail.com>
References: <CAPgLHd-j19gkcuBEVUm5EkUkqXbqZBZ9i74p1WXth89rEaDpJw@mail.gmail.com>
Message-ID: <20131114174058.GH11022@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 10:23:50PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return
> from wmt_i2c_reset_hardware() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to for-next, thanks! Yet, the subject line is really
non-standard (i.e. broken). Should be "i2c: wmt: ..."

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/379287fe/attachment.sig>
