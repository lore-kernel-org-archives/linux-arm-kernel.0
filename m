From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Nov 2017 10:50:54 +0530
Subject: [PATCH v1] dmaengine: stm32_mdma: activate pack/unpack feature
In-Reply-To: <1508247827-31741-1-git-send-email-pierre-yves.mordret@st.com>
References: <1508247827-31741-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20171108052054.GL3187@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 03:43:47PM +0200, Pierre-Yves MORDRET wrote:
> If source and destination bus width differs pack/unpack MDMA
> feature has to be activated for alignment.
> This pack/unpack feature implies to have both source/destination address
> and buffer length aligned on bus width.

Applied, thanks

-- 
~Vinod
