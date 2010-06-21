From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 21 Jun 2010 20:41:02 +0300
Subject: [PATCH V2] GPIO PL061: Adding Clk framework support
In-Reply-To: <1277103463-7311-1-git-send-email-viresh.kumar@st.com>
References: <1277103463-7311-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100621174101.GB11851@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Mon, Jun 21, 2010 at 12:27:43PM +0530, Viresh KUMAR wrote:
> From: Viresh KUMAR <viresh.kumar@st.com>
> 
> GPIO Clk is never enabled on Platforms, like: SPEAr, which are based upon clock
> framework and use PL061 driver. This patch adds support for Clk enabling and
> disabling as and when gpios are requested and freed.
> 
> Modifications since V1:
>  - Removed usage_count, as already done by clk framework.
>  - Checking error case of clk_enable.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
