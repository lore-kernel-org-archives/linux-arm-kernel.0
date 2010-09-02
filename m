From: armando.visconti@st.com (Armando Visconti)
Date: Thu, 2 Sep 2010 10:52:28 +0200
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <4C7F5B9E.8090406@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
	<4C7F5B9E.8090406@st.com>
Message-ID: <4C7F65CC.3010002@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alessandro,
>
>
>> Alessandro can judge on this, but I have a feeling that driver
>> should be replaced by this, more mature driver.
>>   
> Maybe.
> But I suspect that may be few differences in the ECC accelerator 
> inside, in fact.
>
> In our FSMC previous case it was a Hamming accelerator, and I think 
> this apply
> also for nomadik (maybe). In our sp1300 case it is a BCH with 104 
> bytes of ECC.
>
> This is one of the options when generating the h/w block, so FSMCs may 
> differ.
> If we want to re-use same driver I guess we might change something and 
> accept
> few parameters from the platform.
>
> Vipin can for sure comment more on this.....
Mmmh .... it seems that the driver already handles the different types 
of h/w ecc.
And in fact it works for our new and old SPEAr platform at the same
time.

So, probably, it would work for Nomadik also...

Ciao,
Arm
>
>
> Rgds,
> Arm
>


-- 
-- "Every step appears to be the unavoidable consequence of the
-- preceding one." (A. Einstein) 
-- 
Armando Visconti                  Mobile: (+39) 346 8879146
Senior SW Engineer                Fax:    (+39) 02 93519290
CPG                               Work:   (+39) 02 93519683
Computer System Division          e-mail: armando.visconti at st.com
ST Microelectronics               TINA:   051  4683
                                    
 
