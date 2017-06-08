From: angus@akkea.ca (Angus Ainslie)
Date: Thu, 08 Jun 2017 06:43:59 -0600
Subject: Staging r8723bs driver for kernel 4.12.0-rc2 on CHIPPro
In-Reply-To: <1496925243.11482.19.camel@hadess.net>
References: <bcc1a7c44ba34cb077a1df09971d6926@www.akkea.ca>
 <8485e88721d4761d5b1a10ff1eebfd36@www.akkea.ca>
 <1496925243.11482.19.camel@hadess.net>
Message-ID: <6c396e96b0534a710411a1641aeb1e10@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-08 06:34, Bastien Nocera wrote:
> I haven't looked at it again in a long while due to lack of time, but
> that might be a good first pass at the problem, before getting onto the
> CHIP Pro.
> 

I ran out of time as well, I hope to get back to it in a couple of week. 
I could try on the CHIP but I suspect it will have the same issue.

At this point to mmc0 is being detected but the driver doesn't load the 
sdio driver. I've tried various changes to the dts including adding a 
dts match table to the rtl8723bs driver but haven't had any success yet.

I wish ntc would stop coming up with new products and finish the ones 
they already have released.
