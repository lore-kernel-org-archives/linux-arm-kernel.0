From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 28 Mar 2011 17:19:55 +0530
Subject: [PATCH] input/spear-keyboard fix: return IRQ_NONE if (status reg
	& DATA_AVAIL)
In-Reply-To: <1301306037-27666-1-git-send-email-rajeev-dlh.kumar@st.com>
References: <1301306037-27666-1-git-send-email-rajeev-dlh.kumar@st.com>
Message-ID: <AANLkTimbb8nSsk8_qxOitPObBCFHhX7mB9KS_o9O7Gte@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 3:23 PM, Rajeev Kumar <rajeev-dlh.kumar@st.com> wrote:
> We should return IRQ_NONE from interrupt handler in case data is not
> avail for keyboard
>
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Rajeev,

Please keep linux-input at vger.kernel.org in --to of this patch.

--
viresh
