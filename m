From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 3 Apr 2015 22:23:41 +0300
Subject: [PATCH 1/3] ARM: pxa: add gpio-charger configuration on poodle
In-Reply-To: <874moxt42l.fsf@free.fr>
References: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
 <874moxt42l.fsf@free.fr>
Message-ID: <CALT56yOwU2Lu2y1NDiD45KBm=FSm_V+m_0VbN1D5Gfcz7Xd7Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-03 22:16 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
>> Add declration of gpio-charger device for Sharp SL-5600 poodle device.
> Typo here ^.
>
> And I'd like in the commit message to know :
>  - is it the main battery charger (I could look into the code, I know, but I'd
>    like it to be in the commit message anyway) ?

I'll add it to v2.

>  - was it successfully tested on Sharp SL-5600 ?

:)) I wouldn't dare to submit a code that wasn't tested on hw w/o
special notice.


-- 
With best wishes
Dmitry
