From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 23 Apr 2012 13:56:11 -0700
Subject: [PATCH V2 6/6] SPEAr: Switch to common clock framework
In-Reply-To: <ddade82f0666c3186b8a694aa2b79acd3f7e5d50.1334852395.git.viresh.kumar@st.com>
References: <cover.1334852393.git.viresh.kumar@st.com>
 <ddade82f0666c3186b8a694aa2b79acd3f7e5d50.1334852395.git.viresh.kumar@st.com>
Message-ID: <CAJOA=zPUYkD=pcdJqQA3iDqDe4fMobO34V=QSz01Z5Y8zAkmPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resending to lakml since message length was too long]

On Thu, Apr 19, 2012 at 9:28 AM, Viresh Kumar <viresh.linux@gmail.com> wrote:
> SPEAr SoCs used its own clock framework since now. From now on they will move to
> use common clock framework.
>
> This patch updates existing SPEAr machine support to adapt for common clock
> framework.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Hi Viresh,

This series looks good to me, except for the two small comments I had
in patch 1/6.

I also think that this code will not be affected by the changes to
struct clk_hw which are expected from Saravana.  Hopefully you have
avoided a big rebase.

I'll take these into my clk-next branch unless Arnd has any objection
based on arm-soc collisions.

Thanks,
Mike
