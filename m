From: tj@kernel.org (Tejun Heo)
Date: Wed, 10 Aug 2016 12:24:42 -0400
Subject: [PATCH 0/2] STi: Add ports-implemented property support
In-Reply-To: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
References: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
Message-ID: <20160810162442.GM25053@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 05:37:28PM +0200, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
> returns 0. So force HOST_PORTS_IMPL to 1 by using
> ports-implemented DT property.
> Update achci_st driver and STi dts accordingly

Applied to libata/for-4.9.

Thanks.

-- 
tejun
