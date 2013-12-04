From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Dec 2013 13:57:52 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: Fix STi support
In-Reply-To: <1386162613-13492-1-git-send-email-srinivas.kandagatla@st.com>
References: <1386162613-13492-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20131204215752.GA729@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 01:10:13PM +0000, srinivas.kandagatla at st.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch adds ST serial driver (st-asc) and ICPLUS ethernet PHY to
> multi_v7_defconfig. All STi based SOCs use ST-ASC as default serial
> console, and most of the STi SOC based boards have ICPLUS external
> ethernet PHY. These two options makes the system boot nfs root with
> console.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>


Applied, thanks.


-Olof
