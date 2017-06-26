From: philippe.cornu@st.com (Philippe CORNU)
Date: Mon, 26 Jun 2017 16:27:51 +0000
Subject: [PATCH v4 2/6] dt-bindings: display: Add Synopsys DW MIPI DSI DRM
 bridge driver
In-Reply-To: <20170623212556.aptfelaelxsbc2bd@rob-hp-laptop>
References: <1497889685-27349-1-git-send-email-philippe.cornu@st.com>
 <1497889685-27349-3-git-send-email-philippe.cornu@st.com>
 <20170623212556.aptfelaelxsbc2bd@rob-hp-laptop>
Message-ID: <3d7168cc-5584-5e09-4887-5ab9522ba16e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/23/2017 11:25 PM, Rob Herring wrote:
> On Mon, Jun 19, 2017 at 06:28:01PM +0200, Philippe CORNU wrote:
>> This patch adds documentation of device tree bindings for the
>> Synopsys DesignWare MIPI DSI host DRM bridge driver.
> 
> You missed Archit's comment on v3. Bindings are for h/w, not drivers.
> 
> Rob
> 
Dear Rob :-)
sorry to have miss that ones.
I have updated all bindings accordingly (including the optional dpi/rgb 
pixel clock). Everything is now ready for the coming v5 patchset (I am 
waiting for more comments before sending it).
Big thanks :-)
Philippe
