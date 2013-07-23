From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Jul 2013 19:35:40 -0700
Subject: [PATCH v2 2/2] ARM: STi: Set correct ARM ERRATAs.
In-Reply-To: <1373354793-26400-1-git-send-email-srinivas.kandagatla@st.com>
References: <1373354752-26292-1-git-send-email-srinivas.kandagatla@st.com>
 <1373354793-26400-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130723023540.GA14983@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 08:26:33AM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> Some of the ARM_ERRATA selection is not done in the initial SOC support
> patches. This patch selects 2 new ARM_ERRATA's and removes one which was
> actually fixed.

These entries should be sorted, and you inserted in random order.

I'll rearrange the order when applying.

(Patch applied with that change).

Thanks,

-Olof
