From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 19 May 2015 06:05:44 +0300
Subject: [PATCH 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <1431978219-14226-3-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-3-git-send-email-eric@anholt.net>
Message-ID: <20150519030544.GQ2845@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Mon, May 18, 2015 at 12:43:34PM -0700, Eric Anholt wrote:
> +DEFINE_MUTEX(delayed_clock_init);

Static?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
