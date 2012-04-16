From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 09:18:51 +0530
Subject: [PATCH] clk: Allocate and add clock lookups from clk_register()
In-Reply-To: <20120413111604.GA20977@glitch>
References: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
 <20120413111604.GA20977@glitch>
Message-ID: <4F8B96A3.1070303@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 4:46 PM, Domenico Andreoli wrote:
> Basically this is the amount of code you want to save all around, right?
> 
> Why can't be this moved in a different function? So only who wants to
> register the lookup will invoke it after clk_register().

Yes, this is discussed at the end of following thread too. :)

http://www.spinics.net/lists/arm-kernel/msg169133.html

-- 
viresh
