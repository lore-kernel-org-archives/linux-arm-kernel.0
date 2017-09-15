From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 15 Sep 2017 16:56:03 -0700
Subject: [GIT PULL 1/6 V2] Broadcom soc changes for 4.14
In-Reply-To: <20170824194326.29202-1-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170824194326.29202-1-f.fainelli@gmail.com>
Message-ID: <EC4B3C3E-6E48-468D-8F9E-6890999B9F3D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On August 24, 2017 12:43:26 PM PDT, Florian Fainelli <f.fainelli@gmail.com> wrote:
>The following changes since commit
>5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
>are available in the git repository at:
>
>  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/soc
>
>for you to fetch changes up to
>c9351923600e073083fc378c870c593cf98dd551:
>
>Merge tag 'bcm2835-soc-next-2017-08-24' into soc/next (2017-08-24
>11:47:29 -0700)
>
>----------------------------------------------------------------
>This pull request contains Broadcom ARM-based SoC arch/ changes for
>4.14,
>please pull the following:
>
>- Danilo removes the clock provider driver stubs which are no longer
>needed
>  now that we have a proper CPRMAN clock provider driver
>
>- Stefan moves the SMP startup code for BCM2836 from the interrupt
>controller
>driver down to where it belongs in the architecture code, this was
>requested
>  by Marc Zyngier before comitting any fixes to that code
>
>- Phil provides a fix for a future Raspberry Pi firmware which will
>make the
>secondary cores wait for an event and therefore requires the CPU
>onlining
>  other cores to send such event (along with the appropriate barrier)

Olof, Arnd, we talked about this on IRC a few weeks ago, can you take this in next/late? Thank you!

-- 
Florian
