From: pratyush.anand@st.com (Pratyush Anand)
Date: Thu, 17 Jul 2014 09:00:08 +0530
Subject: [PATCH v5 1/5] PCI: designware: add rd[wr]_other_conf API
In-Reply-To: <1405528686-16539-2-git-send-email-m-karicheri2@ti.com>
References: <1405528686-16539-1-git-send-email-m-karicheri2@ti.com>
 <1405528686-16539-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <20140717033008.GG12278@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:38:02AM +0800, Murali Karicheri wrote:
> v3.65 version of the designware h/w, requires application space
> registers to be configured to access the remote EP config space.
> To support this, add rd[wr]_other_conf API in the pcie_host_opts
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Mohit Kumar <mohit.kumar@st.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 

Reviewed-by: Pratyush Anand <pratyush.anand@st.com>
