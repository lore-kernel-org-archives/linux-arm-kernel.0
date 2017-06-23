From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 16:25:56 -0500
Subject: [PATCH v4 2/6] dt-bindings: display: Add Synopsys DW MIPI DSI
 DRM bridge driver
In-Reply-To: <1497889685-27349-3-git-send-email-philippe.cornu@st.com>
References: <1497889685-27349-1-git-send-email-philippe.cornu@st.com>
 <1497889685-27349-3-git-send-email-philippe.cornu@st.com>
Message-ID: <20170623212556.aptfelaelxsbc2bd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 06:28:01PM +0200, Philippe CORNU wrote:
> This patch adds documentation of device tree bindings for the
> Synopsys DesignWare MIPI DSI host DRM bridge driver.

You missed Archit's comment on v3. Bindings are for h/w, not drivers. 

Rob
