From: cjb@laptop.org (Chris Ball)
Date: Sat, 31 Mar 2012 23:43:06 -0400
Subject: [PATCH v2 1/3] mmc: atmel-mci: correct data timeout computation
In-Reply-To: <4F72F9A5.60900@atmel.com> (Nicolas Ferre's message of "Wed, 28
 Mar 2012 13:44:37 +0200")
References: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
 <1332930513-14893-1-git-send-email-ludovic.desroches@atmel.com>
 <4F72F9A5.60900@atmel.com>
Message-ID: <87vclkm81h.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 28 2012, Nicolas Ferre wrote:
> On 03/28/2012 12:28 PM, ludovic.desroches at atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>> 
>> The HSMCI operates at a rate of up to Master Clock divided by two.
>> Moreover previous calculation can cause overflows and so wrong
>> timeouts.
>> 
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
