From: wg@grandegger.com (Wolfgang Grandegger)
Date: Tue, 29 Nov 2011 12:44:22 +0100
Subject: 2.6.38 port not booting on i.MX53 SoM
In-Reply-To: <CAN=k24nyYoajitAAjHUjuy9ZnXDm5As7pJ0un0x_uTibzJfkrw@mail.gmail.com>
References: <CAN=k24ncTxDMXZzO1ef_+ETFiiqJZxtYSEOAKz3DiwCO8UKwcw@mail.gmail.com>
 <20111128100755.GI17668@pengutronix.de>
 <CAN=k24=fjYjz9ygUbwDFvCg6jNAvt4wPUZOufdytpDEx1bLqog@mail.gmail.com>
 <CAOMZO5CSBds93wFiyTeTcbEZa_PzVuNtFfvcziRsh7p-Mu9=dQ@mail.gmail.com>
 <CAN=k24nyYoajitAAjHUjuy9ZnXDm5As7pJ0un0x_uTibzJfkrw@mail.gmail.com>
Message-ID: <4ED4C596.6040700@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2011 12:20 PM, Wayne Tams wrote:
> On Tue, Nov 29, 2011 at 11:12 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> 2011/11/29 Wayne Tams <wayne.tams@gmail.com>:
>>
>>> I have followed your instructions and double checked serial bootargs
>>> by loading the 2.6.35 kernel; 2.6.35 loads ok displaying printks as it
>>> executes.
>>>
>>> However using the new 2.6.38 kernel, there are not any additional
>>> messages after enabling the debug settings you mentioned.
>>
>> As Uwe explained this list is about mainline kernel.
>>
>> I have a suggestion for you though: if you use FSL 2.6.38 you should
>> update your FSL U-boot also because there were some UART clock changes
>> from 2.6.35 to 2.6.38. Or use the mainline kernel instead ;-)
>>
>> Regards,
>>
>> Fabio Estevam
> 
> Understood, thanks for the help all the same. :)

Try the following patch:

http://git.linaro.org/gitweb?p=bsp/freescale/linux-linaro-natty.git;a=commit;h=c00c6cd2b83e88292f82387dacf489b2821d2ce2

Wolfgang.
