From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 15:19:06 +0100
Subject: [PATCH v4 4/6] pinctrl: st: Use ARRAY_SIZE instead of raw value
 for number of delays
In-Reply-To: <1394614210-15698-5-git-send-email-maxime.coquelin@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <1394614210-15698-5-git-send-email-maxime.coquelin@st.com>
Message-ID: <CACRpkdYBZKcuyNyD08K00COLXPYd7HRrapNaWLAW9SK7o0OVaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 9:50 AM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:

> This patch replaces the raw values with ARRAY_SIZE for assigning the
> ninput_delays and noutput_delays fields of STiH416's st_pctl_data struct.
>
> CC: Lee Jones <lee.jones@linaro.org>
> Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>

Patch applied!

Yours,
Linus Walleij
