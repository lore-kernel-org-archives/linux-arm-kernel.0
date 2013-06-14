From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 14 Jun 2013 08:12:35 +0100
Subject: [PATCH v2 07/11] ARM:stixxxx: Add STiH416 SOC support
In-Reply-To: <3733079.FxbR14kFrs@wuerfel>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856425-7135-1-git-send-email-srinivas.kandagatla@st.com>
 <3733079.FxbR14kFrs@wuerfel>
Message-ID: <51BAC263.1000908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/13 14:52, Arnd Bergmann wrote:
> On Monday 10 June 2013 10:27:05 Srinivas KANDAGATLA wrote:
> 
>> > +	soc {
>> > +		pin-controller-sbc {
>> > +			#address-cells	= <1>;
>> > +			#size-cells	= <1>;
>> > +			compatible	= "st,stih416-pinctrl", "simple-bus";
> Why is this both its own device with a compatible string and a
> "simple-bus" at the same time? Wouldn't it be simpler to just
> scan the child device nodes from the "st,stih416-pinctrl"
> driver instead of having a separate platform_driver for them?
> 
I did try this suggestion, and it simplified driver too, I will do this
change in next version.

Thanks,
srini
