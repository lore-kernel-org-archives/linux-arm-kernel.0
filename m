From: armando.visconti@st.com (Armando Visconti)
Date: Thu, 2 Sep 2010 14:33:23 +0200
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <AANLkTikwjCh=2Cekg9R1SqacKXC+_ZgV7m+=ZVVCaDba@mail.gmail.com>
References: <cover.1283161023.git.viresh.kumar@st.com>	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>	<4C7F5B9E.8090406@st.com>
	<AANLkTikwjCh=2Cekg9R1SqacKXC+_ZgV7m+=ZVVCaDba@mail.gmail.com>
Message-ID: <4C7F9993.3040700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 2010/9/2 Armando Visconti <armando.visconti@st.com>:
>
>   
>>> I *highly* suspect that this driver duplicates some code found in
>>> drivers/mtd/nand/nomadik_nand.c because it's the same silicon.
>>>       
>> Why nomadik_nand.c?
>> Shouldn't the fsmc_nand.c rule apply also in this case?
>>     
>
> As I said I think nomadik_nand.c shall be deleted and replaced with
> this driver.
>
> Unless Alessandro hits me on the fingers... If it is made generic
> I can provide testing for the U300. (Maybe I can get my NHK8815
> card booting too, I don't know.)
>   
As I said before, the SPEAr driver should work on Nomadik too
as it looks generic enough and for us it is working
on two different platforms with different FSMC versions.

This, unless the Nomadik FSMC is a customized h/w block, which
I seem to remember in fact ...

Ciao,
Arm


-- 
-- "Every step appears to be the unavoidable consequence of the
-- preceding one." (A. Einstein) 
-- 
Armando Visconti                  Mobile: (+39) 346 8879146
Senior SW Engineer                Fax:    (+39) 02 93519290
CPG                               Work:   (+39) 02 93519683
Computer System Division          e-mail: armando.visconti at st.com
ST Microelectronics               TINA:   051  4683
                                    
 
