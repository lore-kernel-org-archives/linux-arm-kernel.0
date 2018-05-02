From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 2 May 2018 13:57:23 +0000
Subject: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
In-Reply-To: <152521260300.138124.15551649788620481848@swboyd.mtv.corp.google.com>
References: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
 <152521260300.138124.15551649788620481848@swboyd.mtv.corp.google.com>
Message-ID: <fc59c88c-b25a-8e6f-ec14-5e7abba07829@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

This patch is not a critical fix for this merge window.

Thanks

Gabriel


On 05/02/2018 12:10 AM, Stephen Boyd wrote:
> Quoting gabriel.fernandez at st.com (2018-04-24 00:58:43)
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> Don't disable the dbg clock if was set by bootloader.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
> Is this a critical fix for this merge window? Please add "Fixes:" tag.
>
