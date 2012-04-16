From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 09:05:30 +0530
Subject: [PATCH V3 2/4] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <4F884F87.8000205@wwwdotorg.org>
References: <cover.1334207964.git.viresh.kumar@st.com>
 <3d7a76d17b4366e08b45d528a245147095bbcb10.1334207964.git.viresh.kumar@st.com>
 <4F884F87.8000205@wwwdotorg.org>
Message-ID: <4F8B9382.90709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 9:38 PM, Stephen Warren wrote:
> of_iomap isn't a devm function, so youo need to unmap in remove(), and
> in probe()'s error paths.
> 
> Or of course, you could just implement devm_of_iomap(); it's probably
> very simple to do.

Implemented devm_of_iomap().

-- 
viresh
