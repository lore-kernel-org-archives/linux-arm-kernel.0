From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 02 Sep 2010 02:23:25 +0300
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <4C7E3344.2020202@st.com>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>
	<1283170469.12995.53.camel@brekeke>  <4C7CA278.9040902@st.com>
	<1283297810.2018.67.camel@brekeke>  <4C7DD2FD.1080501@st.com>
	<1283337939.1958.20.camel@brekeke>  <4C7E3344.2020202@st.com>
Message-ID: <1283383405.2209.66.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2010-09-01 at 16:34 +0530, Vipin Kumar wrote:
> I got the point, but this change is essential (at least for me). It may be 
> essential to others as well in near future. Please let me know how to handle more 
> than 64 bytes of ecc

Invent new ioctl, and declare the old one deprecated.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
