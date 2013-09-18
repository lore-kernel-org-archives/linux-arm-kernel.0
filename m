From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 18 Sep 2013 07:35:13 +0100
Subject: [PATCH] ARM: STi: remove unused Kconfig parameters
In-Reply-To: <1379474622-4715-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1379474622-4715-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <523949A1.7080600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael.
On 18/09/13 04:23, Michael Opdenacker wrote:
> This patch proposes to remove the 'SOC_STIH415' and 'SOC_STIH416'
> parameters, which are used nowhere else in the source code
> and Makefiles.
> 
> Will they be needed in code that hasn't been submitted yet?
Yes, we will be using it in future patches, for something like reset
controller.
Also I am planning to use in dts/Makefiles so that we can build dtbs for
only selected SOC.

Thanks,
srini
