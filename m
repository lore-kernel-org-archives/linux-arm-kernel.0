From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 28 Aug 2017 20:31:18 -0400 (EDT)
Subject: [v2, 8/8] binfmt_elf_fdpic: fix crash on MMU system with dynamic
 binaries
In-Reply-To: <b552d5ba-fc88-667e-dc56-114367ab7b12@st.com>
References: <20170817072347.19990-9-nicolas.pitre@linaro.org>
 <b552d5ba-fc88-667e-dc56-114367ab7b12@st.com>
Message-ID: <nycvar.YSQ.7.76.1708282030410.2606@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Aug 2017, Vincent ABRIOU wrote:

> Hi Nicolas,
> 
> On 08/17/2017 09:23 AM, Nicolas Pitre wrote:
> > In elf_fdpic_map_file() there is a test to ensure the dynamic section in
> > user space is properly terminated. However it does so by dereferencing
> > a user address directly. Add proper user space accessor.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> Tested-by: Vincent Abriou <vincent.abriou@st.com>

Excellent, thank you!


Nicolas
