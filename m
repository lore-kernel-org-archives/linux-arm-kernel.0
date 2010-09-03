From: sebastian.rasmussen@stericsson.com (Sebastian RASMUSSEN)
Date: Fri, 3 Sep 2010 13:22:49 +0200
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <4C809FBC.8020003@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
	<4C7F5B9E.8090406@st.com> <4C809FBC.8020003@st.com>
Message-ID: <ECD438FDEF6BD742895E554C24725A401602C9EF37@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Adding on top of what Armando has already pointed out, FSMC block may 
> have different versions and each of them may support different features 
> based on its configuration eg. spear device's FSMC block is version8 
> and is configured for 13 byte ecc(per 512 bytes data, BCH8 algorithm). 
> There are other possibilities eg. BCH4, BCH2 etc which are not used in 
> spear devices.

Looking at the future trend of NAND flash memories I believe that BCH8 is
likely to be of most interest, but of course having backwards compatibility
with already existing FSMC block usage is interesting enough.

> Making it generic would also entail supporting all possible configurations 
> through single driver (makes more sense)
[...]
> Alessandro/Sebastian: Is it OK to add a common driver for all FSMC versions
> and customizations

I believe that a common driver is the best way forward, yes. Let me know if I
can assist you in any of the development or testing.

 / Sebastian
