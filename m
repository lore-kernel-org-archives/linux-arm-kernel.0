From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 16 Dec 2015 14:53:02 +0200
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <20151216090454.GL1762@lahna.fi.intel.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com> <20151215145953.GK1762@lahna.fi.intel.com>
 <CAPw-ZT=TcvneyS69GjWe8sFR2hBTpHUUabu8Y5Feup89MwQWQQ@mail.gmail.com>
 <20151216090454.GL1762@lahna.fi.intel.com>
Message-ID: <56715EAE.4080006@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2015 11:04 AM, Mika Westerberg wrote:
> On Tue, Dec 15, 2015 at 11:20:03AM -0800, Loc Ho wrote:
>> Can we not just add an AML method that will return the operation clock
>> frequency that the I2C driver can use? If the method doesn't existed,
>> we will just bail and do nothing or assume what ever default behavior?
>
> Why would you add yet another method? There already are existing ACPI
> *CNT methods that you can use, and are used in systems out there.

One thing to remember that *CNT methods allow more precise machine and 
per bus specific tunings against different HW characteristics like 
pull-up resistance, line load, propagation delay, etc.

-- 
Jarkko
