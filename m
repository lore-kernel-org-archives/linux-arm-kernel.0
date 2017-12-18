From: ludovic.barre@st.com (Ludovic BARRE)
Date: Mon, 18 Dec 2017 09:31:25 +0100
Subject: [PATCH 1/2] serial: stm32: add default console
In-Reply-To: <20171215192517.GA27395@kroah.com>
References: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
 <1512146211-29086-2-git-send-email-ludovic.Barre@st.com>
 <20171215192517.GA27395@kroah.com>
Message-ID: <625c8e7a-f6b0-3997-527d-408cfe9b5730@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Greg

Yes, the machine could be boot without console. but our
boards has a console by default. it is just to simplified the
configuration.
you can abandoned this patch, if you prefer.

BR
Ludo

On 12/15/2017 08:25 PM, Greg Kroah-Hartman wrote:
> On Fri, Dec 01, 2017 at 05:36:50PM +0100, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds by default the console support
>> on stm32.
> 
> Why?  'default y' should only mean "machine will not boot without this".
> And I think your machine will boot without the console, right?  :)
> 
> thanks,
> 
> greg k-h
> 
