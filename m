From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 12 Apr 2017 09:42:57 +0200
Subject: [PATCH v3 01/20] net: stmmac: export
 stmmac_set_mac_addr/stmmac_get_mac_addr
In-Reply-To: <9514c077-1738-ea49-ca18-fbc46bac6144@st.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
 <20170403091444.29876-2-clabbe.montjoie@gmail.com>
 <9514c077-1738-ea49-ca18-fbc46bac6144@st.com>
Message-ID: <20170412074257.GC11170@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 02:39:03PM +0200, Giuseppe CAVALLARO wrote:
> Hello Alex
> 
> do you can check if this has to be done for ST platforms?
> I do not remember that it was necessary when build as module so
> I cannot expect this should be only for dwmac-sun8i.
> 
> Regards
> peppe
> 

dwmac-sun8i is simply the first "user" of stmmac_[sg]et_mac_addr outside of stmmac-objs

Regards
