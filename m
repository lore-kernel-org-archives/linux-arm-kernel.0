From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 8 Oct 2014 13:12:37 +0200
Subject: [RFC PATCH 0/2] mfd: syscon: declare holes in syscon register maps
In-Reply-To: <1412688148-20835-1-git-send-email-seraphin.bonnaffe@st.com>
References: <54244655.1090801@st.com>
 <1412688148-20835-1-git-send-email-seraphin.bonnaffe@st.com>
Message-ID: <54351C25.70604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Seraphin,

On 10/07/2014 03:22 PM, Seraphin Bonnaffe wrote:
> In reply to mail: Holes management in syscon driver.
> 
> Hi Dong, Maxime, Lee, all,
> 
> Regmap also offers .rd_table and .wr_table structures that can be used to
> specify valid ranges within agiven regmap configuration.
> 
> This patch uses these structures to declare holes in a syscon instance.
> It takes the description from DT, and fills in the structures accordingly.
> 
> Can I have your opinion on this implementation ?

As discussed face to face, it looks fine to me.

But we would like green light in the new "holes" property introduced.

Thanks,
Maxime

> 
> Thanks and Regards,
> Seraphin
> 
> Seraphin Bonnaffe (2):
>    mfd: syscon: Document new DT binding "holes"
>    mfd: syscon: specify rd_table and wr_table from DT
> 
>   Documentation/devicetree/bindings/mfd/syscon.txt |  5 ++++
>   drivers/mfd/syscon.c                             | 35 ++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
