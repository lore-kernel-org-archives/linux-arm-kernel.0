From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 1 Nov 2013 12:50:25 +0000
Subject: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <526E7C8C.8080603@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>
 <525FAEED.7030207@st.com> <20131017141957.GE14104@ns203013.ovh.net>
 <525FF498.3060202@st.com> <1382021369.4093.44.camel@weser.hi.pengutronix.de>
 <5260EFDC.804@st.com> <526E7C8C.8080603@st.com>
Message-ID: <5273A391.5000302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/10/13 15:02, Maxime Coquelin wrote:
>>
>> 6> IMHO, the compatible string should be "vendor,<IP-name>-<IP-version>"
>> rather than first SoC.
> I agree.
> In this case, we add support to revision 4 of SSC IP.
Its not the revision its name of the new IP which is SSC4. However  this
driver is also compatible with old SSC IP, so It would be nice to have
something like two compatible strings "st,comms-ssc-i2c" and
"st,comms-ssc4-i2c"

Thanks,
srini
> 
> Is "st,comms-ssc-v4" okay?
