From: viresh.kumar@st.com (Viresh KUMAR)
Date: Tue, 22 Jun 2010 09:37:26 +0530
Subject: [PATCH V2] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100621174101.GB11851@tarshish>
References: <1277103463-7311-1-git-send-email-viresh.kumar@st.com>
	<20100621174101.GB11851@tarshish>
Message-ID: <4C2036FE.40603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/2010 11:11 PM, Baruch Siach wrote:
> Hi Viresh,
> 
> On Mon, Jun 21, 2010 at 12:27:43PM +0530, Viresh KUMAR wrote:
>> From: Viresh KUMAR <viresh.kumar@st.com>
>>
>> GPIO Clk is never enabled on Platforms, like: SPEAr, which are based upon clock
>> framework and use PL061 driver. This patch adds support for Clk enabling and
>> disabling as and when gpios are requested and freed.
>>
>> Modifications since V1:
>>  - Removed usage_count, as already done by clk framework.
>>  - Checking error case of clk_enable.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> 
> Acked-by: Baruch Siach <baruch@tkos.co.il>
> 

Baruch,

Sorry, but you need to review another version.

viresh.
