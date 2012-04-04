From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 4 Apr 2012 09:47:57 +0530
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <CACRpkdZr3cZ=foqfB_r5+2N=sa_ON4=UDjrqmr0acKsc50SHRg@mail.gmail.com>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
 <CACRpkdZr3cZ=foqfB_r5+2N=sa_ON4=UDjrqmr0acKsc50SHRg@mail.gmail.com>
Message-ID: <4F7BCB75.3020804@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2012 2:48 AM, Linus Walleij wrote:
> Ugh this is not looking good, please check Arnds advice in how to restructure
> this a bit... #ifdef is ugly (and error-prone).

Ugliness inherited from Tegra :)

> Apart from this it looks pretty straight-forward. Make sure to rebase
> onto your own patches in linux-next for next version.

I already rebased it latest linux-next/master + my earlier pinctrl patch.
Will fetch linux-next again when i send V2. If my earlier patches for pinmux
are still not present in linux-next/master i will apply my earlier patches
before this one.

-- 
viresh
