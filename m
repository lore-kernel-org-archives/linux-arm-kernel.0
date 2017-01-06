From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 6 Jan 2017 09:51:20 -0600
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <fd82e2bf-5259-2fda-c931-1996387d779f@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
 <1dfdc578-e0f8-1320-d223-c9c55e70ca93@codeaurora.org>
 <fd82e2bf-5259-2fda-c931-1996387d779f@codeaurora.org>
Message-ID: <4bf67a17-bb2f-cc1f-97c5-2d7c50604f60@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christopher Covington wrote:
>> > Looks like you've made an unrelated whitespace change that affected the entire table,
>> > not just the line you're adding.
> I'm making space for "QCOM_FALKOR_ERRATUM_1003".

Ok, but you're also shrinking the other columns.  I think a better 
solution is to make the macro shorter. QCOM_ERRATUM_FLK1003?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
