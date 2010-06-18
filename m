From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 18 Jun 2010 19:03:43 +0530
Subject: Query dw_dmac driver: All descriptors done, but channel not idle!
Message-ID: <4C1B75B7.1080104@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

We have Synopsys Designware DMAC Controller on ST SPEAr13xx platform.
When i run dmatest for all 8 channels then i see following error some times.

"dma dma0chan7: BUG: All descriptors done, but channel not idle!"

I saw the code in driver, and i think it looks to be a known issue for this
peripheral, that's why special handling is done in driver.

Can somebody please confirm, if it a known issue or not? Or if there
are some solutions for this problem.

viresh.
