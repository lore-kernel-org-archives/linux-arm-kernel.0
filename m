From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 6 Sep 2010 15:33:00 +0530
Subject: [PATCH 32/74] ST SPEAr: Adding clk_set_rate support
In-Reply-To: <20100902092123.GJ26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<89c9cebf76e54242ec0d2cb0b7e90b2305db1b39.1283161023.git.viresh.kumar@st.com>
	<20100902092123.GJ26319@n2100.arm.linux.org.uk>
Message-ID: <4C84BC54.6000400@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 2:51 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 30, 2010 at 04:08:56PM +0530, Viresh KUMAR wrote:
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> 
> Can't this patch be rolled into a previous patch - especially as it deletes
> a load of code added by that previous patch (eg, clk_is_enabled)?  It
> doesn't look like it depends on the other various changes between that
> patch and this one.
> .
> 

OK.
