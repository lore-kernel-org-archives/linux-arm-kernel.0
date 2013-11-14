From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Nov 2013 18:00:26 +0100
Subject: [PATCH v6 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <1383726315-27534-2-git-send-email-maxime.coquelin@st.com>
References: <1383726315-27534-1-git-send-email-maxime.coquelin@st.com>
 <1383726315-27534-2-git-send-email-maxime.coquelin@st.com>
Message-ID: <20131114170026.GA11022@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 09:25:12AM +0100, Maxime COQUELIN wrote:
> This patch adds support to SSC (Synchronous Serial Controller)
> I2C driver. This IP also supports SPI protocol, but this is not
> the aim of this driver.
> 
> This IP is embedded in all ST SoCs for Set-top box platorms, and
> supports I2C Standard and Fast modes.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/aead3f5e/attachment.sig>
