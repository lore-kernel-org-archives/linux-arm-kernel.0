From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 30 Sep 2015 11:15:55 +0200
Subject: [PATCH 0/3] ARM: dts: Various STi DT clean-ups
In-Reply-To: <1443037049-6167-1-git-send-email-maxime.coquelin@st.com>
References: <1443037049-6167-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <560BA84B.8080200@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/23/2015 09:37 PM, Maxime Coquelin wrote:
> This series cleans the STi407 family DTs, by factorizing common nodes between
> STiH407 and STiH410, and also by only enabling PWM and USB nodes at board
> level, as they could not be exposed on some boards.
>
> Maxime Coquelin (3):
>    ARM: dts: stih407: Enable PWM nodes only board level
>    ARM: dts: stih407/410: Tidy up display nodes
>    ARM: dts: stih410: Enable USB2.0 and related PHY nodes at board level
>
>   arch/arm/boot/dts/stih407-family.dtsi | 19 +++++++++++++++++--
>   arch/arm/boot/dts/stih407.dtsi        | 13 -------------
>   arch/arm/boot/dts/stih410-b2120.dts   | 24 ++++++++++++++++++++++++
>   arch/arm/boot/dts/stih410.dtsi        | 23 +++++++++++------------
>   arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
>   5 files changed, 60 insertions(+), 27 deletions(-)
>
Thanks for the reviews.
Series applied to sti-dt-for-v4.4

Regards,
Maxime
