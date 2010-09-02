From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Sep 2010 13:15:13 +0200
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <4C7F5B9E.8090406@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>
	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
	<4C7F5B9E.8090406@st.com>
Message-ID: <AANLkTikwjCh=2Cekg9R1SqacKXC+_ZgV7m+=ZVVCaDba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/2 Armando Visconti <armando.visconti@st.com>:

>> I *highly* suspect that this driver duplicates some code found in
>> drivers/mtd/nand/nomadik_nand.c because it's the same silicon.
>
> Why nomadik_nand.c?
> Shouldn't the fsmc_nand.c rule apply also in this case?

As I said I think nomadik_nand.c shall be deleted and replaced with
this driver.

Unless Alessandro hits me on the fingers... If it is made generic
I can provide testing for the U300. (Maybe I can get my NHK8815
card booting too, I don't know.)

Yours,
Linus Walleij
