From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 23 Mar 2012 10:55:44 -0600
Subject: [PATCH 2/2] ARM: GIC: Create common infrastructure for GIC DT
 bindings
In-Reply-To: <23b4d2ea357a7a785b6c42d0fa7ae9478bad552b.1332488625.git.viresh.kumar@st.com>
References: <4bfe7af3761f6f40506a2089fd67866015f6d7f3.1332488625.git.viresh.kumar@st.com>
 <23b4d2ea357a7a785b6c42d0fa7ae9478bad552b.1332488625.git.viresh.kumar@st.com>
Message-ID: <4F6CAB10.2020204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2012 01:49 AM, Viresh Kumar wrote:
> Few platforms define there own struct of_device_id[] for GIC. They don't
> do anything specific in init_irq() other than of_irq_init().
> 
> This patch creates this struct array in gic.c and make other platforms use it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

For Tegra,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
