From: sbranden@broadcom.com (Scott Branden)
Date: Fri, 3 Apr 2015 12:33:12 -0700
Subject: [PATCH 0/2] Cygnus Audio Driver
In-Reply-To: <20150331064338.GE2869@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <20150331064338.GE2869@sirena.org.uk>
Message-ID: <551EEAF8.7050108@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


On 15-03-30 11:43 PM, Mark Brown wrote:
> On Mon, Mar 30, 2015 at 08:16:22PM -0700, Scott Branden wrote:
>
>> The audio PLL is embedded in the audio block and only used
>> by the audio block. The audio PLL registers are also in the middle of
>> the audio register map.
>
> When you say it's only used by the audio block do you mean to say that
> the audio block exposes no clock signals other than the bit and frame
> clocks?
>
The audio block exposes the MCLK in addition to the bit and frame clock.

Regards,
  Scott
