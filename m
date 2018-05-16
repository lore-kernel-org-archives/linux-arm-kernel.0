From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 16 May 2018 05:09:07 +0000
Subject: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
In-Reply-To: <152640858418.34267.5971648282268914967@swboyd.mtv.corp.google.com>
References: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
 <152640858418.34267.5971648282268914967@swboyd.mtv.corp.google.com>
Message-ID: <b72e8ecd-3e33-6f09-4730-eab15a7a5e19@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Stephen


On 05/15/2018 08:23 PM, Stephen Boyd wrote:
> Quoting gabriel.fernandez at st.com (2018-04-24 00:58:43)
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> Don't disable the dbg clock if was set by bootloader.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
> Applied to clk-next
>
