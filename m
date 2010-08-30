From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 30 Aug 2010 15:14:29 +0300
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>
Message-ID: <1283170469.12995.53.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-30 at 16:13 +0530, Viresh KUMAR wrote:
> From: Vipin Kumar <vipin.kumar@st.com>
> 
> For a page size of 4096, the number of oob bytes are 128 per page. This demands
> for an increased ecc_pos array as well as ecc can be placed at more than 64
> locations.
> 
> This patch is added because SPEAr platforms NAND controller has 13 bytes of ecc
> for each 512 bytes of data. This results in 104 bytes of ecc in case of 4096
> byte page.
> 
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Nack, breaking ABI Is not allowed in Linux.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
