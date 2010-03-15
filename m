From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Mon, 15 Mar 2010 15:57:43 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral	Multiplexing)
	in linux
In-Reply-To: <4B9E078C.4010706@st.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DD3A3.7050106@st.com> <4B9DF2FF.3000706@st.com>
	<4B9DF966.6050504@st.com> <4B9E078C.4010706@st.com>
Message-ID: <4B9E0B9F.40506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armando,

On 3/15/2010 3:40 PM, Armando VISCONTI wrote:
>>> So, probably the correct way is passing peripheral selection information
>>> thru
>>> bootargs.
>>> What do you think?
>>>     
>>
>> This is very specific to how an SoC provides multiplexing options and
>> will
>> vary greatly. Which option of bootargs are you talking about?
>>   
> Of course not a standard bootargs option.
> I was more talking about a new specific option that is
> passed thru bootargs and directed to a specific SPEAr function that
> can apply the proper cfg and register setting, like someone (Ben?)
> was suggesting.
> 
> In this option you should pass a bitmap or something like that.
> 
> Let me know your opinion on it.

You may be right.
Please see my other reply on device tree option.

regards
Shiraz
