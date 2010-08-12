From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 12 Aug 2010 10:10:03 +0530
Subject: [PATCH 2/5] SPEAR3xx: Rename register/irq defines to remove naming
	conflicts
In-Reply-To: <4C630B5A.3030509@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
	<4C60DFB8.20608@st.com> <4C61BB85.5050406@bluewatersys.com>
	<4C6269F0.8060109@st.com> <4C630B5A.3030509@bluewatersys.com>
Message-ID: <4C637B23.3050504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 8/12/2010 2:13 AM, Ryan Mallon wrote:
> Right, but the ifdef code about will make sure that if you only compile
> in a single Spear implementation then the VIRQ start will be optimal. If
> you compile multiple Spear implementations in then you get the benefit
> of a single kernel which boots on multiple boards, at the cost of some
> minimal memory wastage in some cases.
>
OK. This is fine. Just remove "//" comment from V2 and i will ack it.

Thanks
viresh.
