From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 24 Mar 2018 23:49:11 +0100
Subject: [PATCH v2 3/6] i2c: i2c-stm32f7: Add initial SMBus protocols
 support
In-Reply-To: <1521650940-11651-4-git-send-email-pierre-yves.mordret@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-4-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180324224911.xz3fz2jojcdrovb4@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 05:48:57PM +0100, Pierre-Yves MORDRET wrote:
> This patch adds SMBus support for I2C controller embedded in STM32F7 Soc.

> All SMBus protocols are implemented except SMBus-specific protocols.

What does that mean?

> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
>     v2:
>        * fix Kbuild test robot issue (Unneeded semicolon)
> ---
> 
> fixup! i2c: i2c-stm32f7: Add initial SMBus protocols support
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 377 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 368 insertions(+), 9 deletions(-)

That is quite some complexity considering we have I2C_FUNC_SMBUS_EMUL. I
don't mind, but you really want that?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180324/aef8ebae/attachment-0001.sig>
