From: r.sricharan@ti.com (R, Sricharan)
Date: Thu, 10 May 2012 18:45:52 +0530
Subject: [PATCH 01/13] ARM: OMAP5: id: Add cpu id for ES versions
In-Reply-To: <20120510130637.GA24672@game.jcrosoft.org>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-2-git-send-email-r.sricharan@ti.com>
 <20120510130637.GA24672@game.jcrosoft.org>
Message-ID: <CAJ7qFSeEwxdmqBxZdmABwthnTH1EWZJLJp68To8zit0XLWQhHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J,

> why do you duplicate this
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? case 1:
>> + ? ? ? ? ? ? ? ? ? ? omap_revision = OMAP5430_REV_ES2_0;
>> + ? ? ? ? ? ? ? ? ? ? break;
> do this
>
> ? ? ? ? ? ? ? ?case 0:
>> + ? ? ? ? ? ? default:
>> + ? ? ? ? ? ? ? ? ? ? omap_revision = OMAP5430_REV_ES1_0;
>> + ? ? ? ? ? ? }
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case 0xb998:
>> + ? ? ? ? ? ? switch (rev) {
>> + ? ? ? ? ? ? case 0:
>> + ? ? ? ? ? ? ? ? ? ? omap_revision = OMAP5432_REV_ES1_0;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? default:
> ditto here

   Agree. Will correct the redundancy.

Thanks,
 Sricharan
