From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Wed, 28 Feb 2018 22:04:52 +0200
Subject: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
In-Reply-To: <20180228194429.GD22932@mithrandir>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
 <20180228194429.GD22932@mithrandir>
Message-ID: <87r2p4hod7.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Feb 2018, Thierry Reding <thierry.reding@gmail.com> wrote:
> Anyone that needs something other than normal mode should use the new
> atomic PWM API.

At the risk of revealing my true ignorance, what is the new atomic PWM
API? Where? Examples of how one would convert old code over to the new
API?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
