From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 May 2013 00:15:15 +0200
Subject: [PATCHv2 0/3] Add G762/G763 PWM fan controller
In-Reply-To: <cover.1369687670.git.arno@natisbad.org>
References: <cover.1369687670.git.arno@natisbad.org>
Message-ID: <152190814.eApXVbVBPA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 May 2013 00:02:29 Arnaud Ebalard wrote:
> 
> This series adds support for GMT G762/G763. This work is based on a
> basic version for 2.6.31 kernel developed Olivier Mouchet for LaCie
> NAS. Updates have been performed to run on recent kernels. Support has
> been completed and additional features added: ability to configure
> various characteristics from .dts file, better initialization, alarms
> and error reporting support, gear mode, polarity, fan pulse per
> revolution, fan startup voltage control.

I wonder if this could be split into two separate drivers, one for
the pwm subsystem, and one for a hardware-independent fan controller
based on the pwm interfaces.

	Arnd
