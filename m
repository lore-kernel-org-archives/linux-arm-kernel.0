From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 Nov 2011 16:21:07 +0530
Subject: [PATCH 1/6] spi/pl022: only enable RX interrupts when TX is
 complete
In-Reply-To: <1320835130-31201-1-git-send-email-linus.walleij@stericsson.com>
References: <1320835130-31201-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4EBA5B1B.7020407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/2011 4:08 PM, Linus WALLEIJ wrote:
> +	/* default is to enable all interrupts except RX -
> +	 * this will be enabled once TX is complete
> +	 */

Other than fixing this multiline comment, everything other looks fine.

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
