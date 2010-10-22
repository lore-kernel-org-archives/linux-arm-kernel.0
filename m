From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 22 Oct 2010 14:03:46 +0200
Subject: [PATCH] mx3: Enable PWM clock on mx31 and mx35
In-Reply-To: <396642.10697.qm@web51007.mail.re2.yahoo.com>
References: <396642.10697.qm@web51007.mail.re2.yahoo.com>
Message-ID: <4CC17DA2.6020601@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Le 22/10/2010 13:13, Fabio Estevam a ?crit :
> mx3: Enable PWM clock on mx31 and mx35.
>
Are you sure this in needed as when using the pwm.c driver in plat-mxc there 
are pwm_enable and pwm_disable functions ?

With your patch, platforms without PWM will have the pwm clock enabled.

Eric
