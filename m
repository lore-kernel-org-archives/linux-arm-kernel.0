From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 22 Apr 2013 17:59:26 +0100
Subject: [PATCH v1] ARM: do not select ARCH_VEXPRESS by default on
 ARCH_MULTI_V7
In-Reply-To: <1366634604-12637-1-git-send-email-srinivas.kandagatla@st.com>
References: <1366634604-12637-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1366649966.3203.40.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

On Mon, 2013-04-22 at 13:43 +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch removes ARCH_VEXPRESS selection as default when ARCH_MULTI_V7
> is selected. ARCH_VEXPRESS should be selected from
> mach-vexpress/Kconfig.
> 
> Without this patch, any multiplatform build will have ARCH_VEXPRESS
> selected, as a result all the vexpress associated dtbs are build when we
> make dtbs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Fabio was looking at this some time ago:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/201499
He may comment on the relevant issues.

Cheers!

Pawe?
