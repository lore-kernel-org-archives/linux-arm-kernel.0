From: linux@solonet.org.ua (Denis Kuzmenko)
Date: Tue, 13 Dec 2011 23:33:33 +0200
Subject: [PATCH v3 resend2] s3c/s3c24xx: arm: leds: Make s3c24xx LEDS
 driver use gpiolib
In-Reply-To: <1323811732.3837.27.camel@joe2Laptop>
References: <4EE7B41C.5080006@solonet.org.ua>	
 <1323810417.3837.25.camel@joe2Laptop> <4EE7C1C9.8080000@solonet.org.ua>
 <1323811732.3837.27.camel@joe2Laptop>
Message-ID: <4EE7C4AD.8090805@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2011 11:28 PM, Joe Perches wrote:
> On Tue, 2011-12-13 at 23:21 +0200, Denis Kuzmenko wrote:
>> Hi Joe,
>> Thank you for review.
>>
>> On 12/13/2011 11:06 PM, Joe Perches wrote:
>>> On Tue, 2011-12-13 at 22:22 +0200, Denis Kuzmenko wrote:
>>>> Make s3c24xx LEDS driver use gpiolib. Fix error disabling pull during probe.

> Your choice, but I think consistency is better.
> 
> The LEDF_ACTLOW use is dependent on it being #defined
> to 1 when using ^.  I think that's unintelligible.

Sorry, can't understand. Can you please clarify last two sentences?

-- 
Best regards, Denis Kuzmenko.
