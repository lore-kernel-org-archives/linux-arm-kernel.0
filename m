From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Apr 2015 21:16:50 +0200
Subject: [PATCH 1/3] ARM: pxa: add gpio-charger configuration on poodle
In-Reply-To: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Mon, 30 Mar 2015 13:39:29 +0300")
References: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <874moxt42l.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Add declration of gpio-charger device for Sharp SL-5600 poodle device.
Typo here ^.

And I'd like in the commit message to know :
 - is it the main battery charger (I could look into the code, I know, but I'd
   like it to be in the commit message anyway) ?
 - was it successfully tested on Sharp SL-5600 ?

Cheers.

--
Robert
