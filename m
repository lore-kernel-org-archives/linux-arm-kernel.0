From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 09:39:37 +0530
Subject: [PATCH V2 6/6] SPEAr: Switch to common clock framework
In-Reply-To: <CAJOA=zOvyJ9pqEqnhmU1CqHy1uPUOyC=c7VtKjkjK91cbHkGHw@mail.gmail.com>
References: <cover.1334852393.git.viresh.kumar@st.com>
 <ddade82f0666c3186b8a694aa2b79acd3f7e5d50.1334852395.git.viresh.kumar@st.com>
 <CAJOA=zOvyJ9pqEqnhmU1CqHy1uPUOyC=c7VtKjkjK91cbHkGHw@mail.gmail.com>
Message-ID: <4F962781.5020900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 2:12 AM, Turquette, Mike wrote:
> I also think that this code will not be affected by the changes to
> struct clk_hw which are expected from Saravana.  Hopefully you have
> avoided a big rebase.
> 
> I'll take these into my clk-next branch unless Arnd has any objection
> based on arm-soc collisions.

That sounds good.
I will send V3, for it. That will contain two additional dependency patches:

- clk: add a fixed factor clock - by Sascha Hauer
- CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *

-- 
viresh
