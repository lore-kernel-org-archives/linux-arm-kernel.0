From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 11:44:24 -0500
Subject: [PATCH] ARM: orion5x: Fix typo in device_type property of phy node
In-Reply-To: <1384440788-3529-1-git-send-email-srinivas.kandagatla@st.com>
References: <1384440788-3529-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20131124164424.GE29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:53:08PM +0000, Srinivas Kandagatla wrote:
> This patch fixes a typo for device_type property of phy node.
> This can work as of today but once a checks are added in generic code
> this typo will stop phy from working.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to mvebu/dt with Andrew's Ack.

thx,

Jason.
