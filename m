From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 13 May 2016 12:41:32 +0200
Subject: [PATCH] i2c: st: Implement bus clear
In-Reply-To: <1462983719-342-1-git-send-email-peter.griffin@linaro.org>
References: <1462983719-342-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160513104132.GG1778@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 05:21:59PM +0100, Peter Griffin wrote:
> From I2C specifications:
>       http://www.nxp.com/documents/user_manual/UM10204.pdf
> 
> Chapter 3.1.16, when the i2c device held the SDA line low, the master
> should send 9 clocks pulses to try to recover.
> 
> Signed-off-by: Frederic Pillon <frederic.pillon@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Applied to for-next, thanks! Please us PATCH V<n> next time.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160513/6f945531/attachment.sig>
