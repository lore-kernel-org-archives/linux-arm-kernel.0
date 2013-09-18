From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Wed, 18 Sep 2013 13:52:25 +0200
Subject: [PATCH] ARM: STi: remove unused Kconfig parameters
In-Reply-To: <523949A1.7080600@st.com>
References: <1379474622-4715-1-git-send-email-michael.opdenacker@free-electrons.com>
 <523949A1.7080600@st.com>
Message-ID: <523993F9.6000705@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini

On 09/18/2013 08:35 AM, Srinivas KANDAGATLA wrote:
> Hi Michael.
> On 18/09/13 04:23, Michael Opdenacker wrote:
>> This patch proposes to remove the 'SOC_STIH415' and 'SOC_STIH416'
>> parameters, which are used nowhere else in the source code
>> and Makefiles.
>>
>> Will they be needed in code that hasn't been submitted yet?
> Yes, we will be using it in future patches, for something like reset
> controller.
> Also I am planning to use in dts/Makefiles so that we can build dtbs for
> only selected SOC.
>
> Thanks,
> srini
Thanks for your reply. That's fine for me if you have plans to use these
parameters.

Cheers,

Michael.

-- 
Michael Opdenacker, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
