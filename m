From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Jun 2013 23:17:38 +0200
Subject: [PATCHv4 1/1] Add support for GMT G762/G763 PWM fan controllers
In-Reply-To: <20130615182500.GA32205@roeck-us.net> (Guenter Roeck's message of
 "Sat, 15 Jun 2013 11:25:00 -0700")
References: <87li6bmjwi.fsf@natisbad.org> <20130615182500.GA32205@roeck-us.net>
Message-ID: <87txkzjcp9.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

Thanks for the fast feedback. I will resend a version to handle your
comments. I also noticed I forgot to correctly balance
clk_prepare_enable() by some clk_disable_unprepare() call in case of
error.

Cheers,

a+
