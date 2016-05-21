From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 May 2016 10:37:14 +0200
Subject: [PATCH 1/1] ASoC: pxa: Fix module autoload for platform drivers
In-Reply-To: <1462548454-28597-1-git-send-email-andrea.adami@gmail.com>
 (Andrea Adami's message of "Fri, 6 May 2016 17:27:34 +0200")
References: <1462548454-28597-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <8760u7iz7p.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrea Adami <andrea.adami@gmail.com> writes:

> These platform drivers are lacking MODULE_ALIAS so module autoloading
> doesn't work. Tested on corgi and poodle with kernel 4.4.
>
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
Yes, why not.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
