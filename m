From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 7 Mar 2014 11:26:49 +0000
Subject: [PATCH v2 3/5] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <5319AD5C.7050301@st.com>
References: <1394185272-26054-1-git-send-email-maxime.coquelin@st.com>
 <1394185272-26054-4-git-send-email-maxime.coquelin@st.com>
 <5319A263.6020201@st.com> <5319AD5C.7050301@st.com>
Message-ID: <5319ACF9.4040504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/14 11:28, Maxime Coquelin wrote:
>>
> 
> Problem is that "oe" and "pu" takes -1 in that patch, and these values
> will be passed directly to devm_regmap_field_alloc without any check.
> 
> I propose to apply this patch before "pinctrl: st: add pinctrl support
> for the STiH407 SoC", and move stih407_flashdata as you recommend.
> 
> Is it fine for you?
Am OK with re-ordering, This will also be good for git bisect... :-)


Thanks,
srini

> 
> Thanks for the review,
> Maxime
