From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 02 Sep 2010 12:49:37 +0300
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <4C7F4526.105@gmail.com>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>
	<1283170469.12995.53.camel@brekeke>	<4C7CA278.9040902@st.com>
	<1283297810.2018.67.camel@brekeke>	<4C7DD2FD.1080501@st.com>
	<1283337939.1958.20.camel@brekeke>	<4C7E3344.2020202@st.com>
	<4C7EC43B.2050903@bluewatersys.com>
	<AANLkTinmEck5413ZuCDMB1jyBjH63Uh=L+87q8V4Ek1X@mail.gmail.com>
	<4C7ED1E9.4050208@bluewatersys.com>  <4C7F4526.105@gmail.com>
Message-ID: <1283420977.1748.6.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-01 at 23:33 -0700, Brian Norris wrote:
> 
> I'm curious how many applications actually need to have the ecclayout.
> nandwrite doesn't actually use it, just oobinfo. 

That is good point - I think we should not accept new ioctl before the
submitter shows us how and for what he will use it.

My point is simple - OOB layout should be transparent to users-space.
Messing with this is error-prone.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
