From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 13:41:08 -0700
Subject: [PATCH 0/2] ARM: STi: SMP related fixes.
In-Reply-To: <1375359131-21693-1-git-send-email-srinivas.kandagatla@st.com>
References: <1375359131-21693-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130804204108.GH15602@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 01:12:11PM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> Hi Anrd/Olof,
> These two patches fix a critical SMP issue with STi SOCs. Without this patches
> STi SoCs will boot only single core and crashes after freeing the init.

Applied both for 3.11-rc. Thanks.


-Olof
