From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 11:23:42 +0000
Subject: [PATCH 1/3] ARM: DT: STi: Add support to B2020 revision E board.
In-Reply-To: <531EEA39.50504@st.com>
References: <1394533324-20299-1-git-send-email-lee.jones@linaro.org>
 <531EEA39.50504@st.com>
Message-ID: <20140311112342.GE21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> >
> >This patch adds support to rev E board of B2020 which has few minor
> >changes :
> >	PHY reset PIO (Change from PIO30 to PIO07)
> >	Power LED(Green) Control(Change from PIO47 to PIO13)
> 
> I thought we decided last October to support only one revision of
> the b2020 board.
> 
> The idea was to create an external git to provide DTS for all our
> boards, and only have a minimal subset in in the kernel.

Ah, I was unaware of that conversation/decision. If that's the case we
can scrap this submission along with the following patch.

JOOI, what happens if I want to boot Mainline on my revE board? It
won't be fully functional will it? That will be a shame. The LEDs, not
so much, but networking is a pretty big piece of functionality to
lose.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
