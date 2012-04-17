From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 17 Apr 2012 21:46:41 +0400
Subject: [PATCH 13/13] SPEAr: Call clk_prepare() before calling clk_enable
In-Reply-To: <0c2dc6d1f11ac1cc4965b8e902d19fb356f0324b.1334660432.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <0c2dc6d1f11ac1cc4965b8e902d19fb356f0324b.1334660432.git.viresh.kumar@st.com>
Message-ID: <4F8DAC81.8020400@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/17/2012 03:15 PM, Viresh Kumar wrote:

> With common clock framework, it is must to call clk_{un}prepare() before/after

    Can't parse "it is must to call". Maybe simply "[we] must call"?

> clk_{dis}enable. This patch fixes this for SPEAr timer.

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>

WBR, Sergei
