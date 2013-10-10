From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 10 Oct 2013 11:39:02 +0200
Subject: [PATCH v4 0/4] Add I2C support to ST SoCs
In-Reply-To: <1381250576-7916-1-git-send-email-maxime.coquelin@st.com>
References: <1381250576-7916-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <525675B6.4080404@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 10/08/2013 06:42 PM, Maxime COQUELIN wrote:
> The goal of this series is to add I2C support to ST SoCs.
> The DT definition is added for STiH415 and STiH416 SoCs on
> B2000 and B2020 boards.
>
> The series has been tested working on STiH416-B2020 board.
> It applies on top of v3.12-rc4.
>
> Changes since v3:
>    - Switch back to vendor specific DT properties regarding the anti-glitch
>      filter configuration, as this IP is the only one having such a filter.
Do you agree to keep these properties vendor-specifics?

If so, could you take this series for v3.13?

Thanks,
Maxime
