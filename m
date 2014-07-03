From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 03 Jul 2014 11:20:48 +0200
Subject: [PATCH v2 0/4] Add reset controllers for STiH407 SoC
In-Reply-To: <53B50EFD.2070007@st.com>
References: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
 <1404317194.4109.13.camel@paszta.hi.pengutronix.de>
 <20140702165924.GB17665@lee--X1> <53B50EFD.2070007@st.com>
Message-ID: <1404379248.18039.31.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, den 03.07.2014, 10:06 +0200 schrieb Maxime Coquelin:
> I will queue patch 4 to STi DT branch for v3.17.
> For now, no nodes uses reset for STiH407, so we don't need the 
> dt-bindings header file in the STi tree.
> 
> If we have a DT node using a reset line before my pull-request, I might 
> have to integrate the series in the STi DT branch.
> Philipp, does that sound reasonable?

Patch 4 depends on patch 1 for the header. My tree is still empty, how
about I take the first two, and you merge that branch and then take 3
and 4 on top?

    git://git.pengutronix.de/git/pza/linux.git reset/for_v3.17

Lee, shall I also add your Ack to the documentation patch?

regards
Philipp
