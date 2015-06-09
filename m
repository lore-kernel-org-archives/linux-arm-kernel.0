From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 9 Jun 2015 11:21:28 +0200
Subject: [PATCH 0/2]  Add code to release secondary cores from holding pen.
In-Reply-To: <1433780219-1245-1-git-send-email-peter.griffin@linaro.org>
References: <1433780219-1245-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <5576B018.9050603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 06/08/2015 06:16 PM, Peter Griffin wrote:
> I can't test this on a STiH418 platform, as I don't have one, but a similar
> DT change will be required there as well. I'm not sure if u-boot uses
> the same SBC DMEM offset by default or not.
It should have changed.
Could you also patch STiH418 DT to add cpu-release-addr in CPU 2 & 3 nodes?

Thanks,
Maxime
