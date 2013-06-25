From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Jun 2013 13:30:02 -0700
Subject: [PATCH v5 0/7] ARM:sti: Add STiH415/STiH416 platform and board
 support
In-Reply-To: <1372158822-19160-1-git-send-email-srinivas.kandagatla@st.com>
References: <1372158822-19160-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130625203002.GA15068@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 12:13:42PM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch-set adds basic support for STMicroelectronics STi series SOCs
> which includes STiH415 and STiH416 with B2000 and B2020 board support.
> 
> STiH415 and STiH416 are dual-core ARM Cortex-A9 CPU, designed for use in
> Set-top-boxes. The SOC support is available in mach-sti which contains
> support code for STiH415, STiH416 SOCs including the generic board support.
> 
> The reason for adding two SOCs at this patch set is to show that no new
> C code is required for second SOC(STiH416) support.
> 
> This patch-set only contains the SOC support, all the driver support for
> this platform are submitted to respective mailing lists.
> 
> Changes since v4:
> 	- Renamed mach-stixxxx to mach-sti as suggested by Olof J.

Thanks!

I've merged this into next/late, and I'll drop the previous test merge by Arnd
of the last version of the patch set.


-Olof
