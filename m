From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Apr 2017 15:27:36 -0500
Subject: [PATCH v2 3/7] includes: dt-bindings: Rename STM32F429 pinctrl
 DT bindings
In-Reply-To: <1491568984-20169-4-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-4-git-send-email-alexandre.torgue@st.com>
Message-ID: <20170410202736.zy7naw74hvrdmfzk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 02:43:00PM +0200, Alexandre TORGUE wrote:
> STM32F4 MCU series is composed of several SOC (STM32F429, STM32F469, ...).
> Most of muxing definition are identical. So to avoid to duplicate bindings
> definition, this patch create common definitions.

This is a lot of churn. Some confirmation that the resultant dtb is the 
same before and after would be nice. Perhaps the script you used to 
convert this as well.

Rob
