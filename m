From: silvio.maillist@gmail.com (Silvio F.)
Date: Thu,  7 Nov 2013 14:54:25 +0100
Subject: [PATCH v3] add support for i.MX6 based cpu modul dmo edmqmx6
In-Reply-To: <20131107021355.GA5994@S2101-09.ap.freescale.net>
References: <20131107021355.GA5994@S2101-09.ap.freescale.net>
Message-ID: <1383832467-20349-1-git-send-email-silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I hope now is all correct?!

Cheers,
    Silvio

This patches adds support for the i.MX6 based cpu module edmqmx6 from Data
Modul.

v3:
    * rebase to commit deb07cd3
      git://git.linaro.org/people/shawnguo/linux-2.6.git
    * include suggestions from
      http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/209676.html
    * remove second stmpe because problems with two stmpes
      sysfs: cannot create duplicate filename
      '/bus/platform/devices/stmpe-gpio'

v2:
    * rebase to commit db882158
      git://git.linaro.org/people/shawnguo/linux-2.6.git

v1:
    * Add support
