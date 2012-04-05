From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 12:35:34 +0530
Subject: Query: clk: Defining new struct clk_foo types
Message-ID: <4F7D443E.3010800@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

I am doing SPEAr SoCs clock port with common clock framework.

Currently there are following type of clk_foo implementations present:
- clk_gate
- clk_divider
- clk_fixed_rate
- clk_mux

I have few more in my SoC:
clk with:
- gate + divider
- gate + fixed_rate
- gate + mux
...

How should i go ahead in my implementation for these?
Should i create SPEAr specific structures or enhance drivers/clk for this?

-- 
viresh
