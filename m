From: olof@lixom.net (Olof Johansson)
Date: Mon, 24 Jun 2013 10:54:15 -0700
Subject: [PATCH v4 0/7] ARM:STixxxx: Add STixxxx platform and board support
In-Reply-To: <1371811076-27168-1-git-send-email-srinivas.kandagatla@st.com>
References: <1371811076-27168-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130624175415.GA31429@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 11:37:56AM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> Thankyou all for reviewing the v3 patches.
> 
> This patch-set adds basic support for STMicroelectronics STixxxx SOCs
> which includes STiH415 and STiH416 with B2000 and B2020 board support.
> 
> STiH415 and STiH416 are dual-core ARM Cortex-A9 CPU, designed for use in
> Set-top-boxes. The SOC support is available in mach-stixxxx which contains
> support code for STiH415, STiH416 SOCs including the generic board support.
> 
> The reason for adding two SOCs at this patch set is to show that no new
> C code is required for second SOC(STiH416) support.
> 
> This patch-set only contains the SOC support, all the driver support for
> this platform are submitted to respective mailing lists.

Hi,

I think these are looking quite reasonable, and I am ready to apply them
to 3.11.

However, I have one bikeshed comment. I find the name of the platform to be
awkward. Would you mind naming it mach-sti instead?


-Olof
