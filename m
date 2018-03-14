From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 14 Mar 2018 14:53:17 +0000
Subject: [PATCH v4 3/3] ARM: dts: STi: Remove "console=ttyASN" from
 bootargs for STi boards
In-Reply-To: <20180314135701.GA20286@kroah.com>
References: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
 <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
 <20180314135701.GA20286@kroah.com>
Message-ID: <55befee5-dd68-c175-6d20-29ccda6f323f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg

On 03/14/2018 02:57 PM, Greg KH wrote:
> On Wed, Mar 07, 2018 at 06:35:34PM +0100, patrice.chotard at st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> As serial interface is already specified into stdout-path property,
>> "console=ttyASN,115200" from bootargs can be removed.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>> v4: _ none
>> v3: _ remove "console=serialN,115200" from bootargs and use prefered
>>        stdout-path property
>> v2: _ none
>>
> 
> This patch does not apply at all, are you sure you made it correctly?
> 
> Can you please fix it up and resend?

No problem, the patch has just been sent.

Thanks

Patrice

> 
> thanks,
> 
> greg k-h
> 
