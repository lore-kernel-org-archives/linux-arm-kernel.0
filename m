From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Jul 2011 17:01:12 +0530
Subject: [PATCH 15/18] dmaengine/amba-pl08x: Pass flow
	controller	information with slave channel data
In-Reply-To: <20110729111049.GI25640@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<2f6001455c4e54f56716a245c7e319eb25a9bb0d.1311936524.git.viresh.kumar@st.com>
	<20110729111049.GI25640@n2100.arm.linux.org.uk>
Message-ID: <4E329A00.2090008@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2011 04:40 PM, Russell King - ARM Linux wrote:
> Please, no, don't go back to encoding the flow mask into the platform
> data.  Instead use 'fc' as an indication of who should be the flow
> controller, and hav ethis select the flow control based on both
> 'fc' and the direction.

Ok.

-- 
viresh
