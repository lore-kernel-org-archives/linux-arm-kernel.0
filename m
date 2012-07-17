From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 09:15:13 +0000
Subject: [PATCH v2 0/4] Clk: SPEAr: Rename clk ids within predefined limit
In-Reply-To: <CAOh2x=k1YifBUL4Wr78YJQNyLv4i8nOLdCChEHWBJ0thv5u98A@mail.gmail.com>
References: <cover.1342411982.git.vipulkumar.samar@st.com>
 <CAOh2x=k1YifBUL4Wr78YJQNyLv4i8nOLdCChEHWBJ0thv5u98A@mail.gmail.com>
Message-ID: <201207170915.14246.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, viresh kumar wrote:
> 
> On Mon, Jul 16, 2012 at 5:25 AM, Vipul Kumar Samar
> <vipulkumar.samar@st.com> wrote:
> > The max limit of con_id is 16 and dev_id is 20. As of now for all SPEAr SOC's
> > clk ids are exceeding this predefined limit.
> >
> > This patch set is intended to rename clk ids through out spear clk framework.
> >
> > -v2:
> > -Rename gpt timer parent clk id on spear3xx and spear6xx machine as pll3_48m_clk
> > is renamed to pll3_clk.
> >
> >
> > Vipul Kumar Samar (4):
> >   clk:spear1340:Fix: Rename clk ids within predefined limit
> >   clk:spear1310:Fix: Rename clk ids within predefined limit
> >   Clk:spear3xx:Fix: Rename clk ids within predefined limit
> >   Clk:spear6xx:Fix: Rename clk ids within predefined limit
> 
> Looks Good.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

What's the plan for these patches? Are you (either of you) sending a pull request
for v3.6 or are they actually required for v3.5 as well?

	Arnd
