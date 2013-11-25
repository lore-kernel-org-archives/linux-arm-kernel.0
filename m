From: denis.ciocca@st.com (Denis CIOCCA)
Date: Mon, 25 Nov 2013 09:37:26 +0100
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
In-Reply-To: <52926901.9080004@kernel.org>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com> <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org>
Message-ID: <52930C46.801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,
>> Yes, it is, but only for i2c as far as I'm aware, and usually the DT compatibles are with - as a separator (I
>> looked into the ePAPR, but couldn't get any explanations or requirements on this, even though it's used in all of
>> their examples)
> In other discussions, where the defacto i2c device tree bindings have
> been followed, the conclusion has been that to change to a - from _
> would result in userspace ABI changes, so whilst no one wants _
> the discussion has concluded we can't really avoid it.
Ok, I understood the point. Thanks,

Denis
