From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 18 Sep 2015 11:38:38 +0200
Subject: [PATCH] ARM: pxa: add wm9713 codec
In-Reply-To: <55FBCF05.2090707@compulab.co.il> (Igor Grinberg's message of
 "Fri, 18 Sep 2015 11:44:53 +0300")
References: <1442432561-32722-1-git-send-email-robert.jarzmik@free.fr>
 <55FBCF05.2090707@compulab.co.il>
Message-ID: <87wpvoqd7l.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> Hi Robert,
>
> On 09/16/15 22:42, Robert Jarzmik wrote:
>> The mioa701 is using the wm9713 for audio, battery and touchscreen. Add
>> the missing audio part, which disappeared.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> The subject is a bit misleading..
> I think it is worth specifying mioa701 in subject..
Absolutely, it is even a requirement to have "ARM: pxa: mioa701: " as a prefix.

Thanks for catching this.

-- 
Robert
