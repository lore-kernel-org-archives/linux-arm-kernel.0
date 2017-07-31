From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 31 Jul 2017 09:30:54 +0000
Subject: [PATCH 4/9] serial: stm32: fix pio transmit timeout
In-Reply-To: <20170730143256.GA30584@kroah.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
 <1499958494-19354-5-git-send-email-bich.hemon@st.com>
 <20170730143256.GA30584@kroah.com>
Message-ID: <b1eb499b-4099-6109-7516-3b872175b8f9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 07/30/2017 04:32 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 13, 2017 at 03:08:28PM +0000, Bich HEMON wrote:
>> From: Gerald Baeza <gerald.baeza@st.com>
>>
>> 100?s was too short for low speed transmission
>> (9600bps)
>>
>> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
>> Signed-off-by: Bich Hemon <bich.hemon@st.com>
>> ---
>>   drivers/tty/serial/stm32-usart.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This patch did not apply :(
> 

I have rebased the patch on top of your tty-next branch . Please drop 
this patch as I will send you a new version.

Thx,

Bich
