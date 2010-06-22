From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 22 Jun 2010 20:06:49 +0300
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100622170649.GC11851@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Tue, Jun 22, 2010 at 10:37:27AM +0530, Viresh KUMAR wrote:
> From: Viresh KUMAR <viresh.kumar@st.com>
> 
> GPIO Clk is never enabled on Platforms, like: SPEAr, which are based upon clock
> framework and use PL061 driver. This patch adds support for Clk enabling and
> disabling as and when gpios are requested and freed.
> 
> Modifications in V4:
>  - Not registering gpio_request and gpio_free if clk is not found.
> 
> Modifications in V3:
>  - if clk_get returns -ENOENT, then work without clk enable/disable.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
