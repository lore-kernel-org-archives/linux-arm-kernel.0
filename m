From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 11 Jan 2012 12:20:28 +0530
Subject: [PATCH] dmaengine/dw_dmac: Hibernation support in dw_dmac
In-Reply-To: <4F0D2B75.7000800@st.com>
References: <1326262989-18608-1-git-send-email-rajeev-dlh.kumar@st.com>
 <4F0D2B75.7000800@st.com>
Message-ID: <4F0D3134.4090209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2012 11:55 AM, Deepak SIKRI wrote:
>> +	.freeze_noirq = dw_suspend_noirq,
>> +	.thaw_noirq =	dw_resume_noirq,
>> +	.restore_noirq = dw_resume_noirq,

You need to add poweroff_noirq too.

-- 
viresh
