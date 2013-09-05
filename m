From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 5 Sep 2013 14:25:00 +0200
Subject: [PATCH v2 RFT 2/2] PM / Hibernate: add section for resume options
In-Reply-To: <1377652437-2379-3-git-send-email-sebastian.capella@linaro.org>
References: <1377652437-2379-1-git-send-email-sebastian.capella@linaro.org>
 <1377652437-2379-3-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20130905122500.GE15161@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue 2013-08-27 18:13:57, Sebastian Capella wrote:
> Expand the existing documentation to explicitly list the options for
> resuming a hibernation image, including the manual resume option which
> can be used from the initrd or initramfs and the kernel init resume.

...it also fixes sysfs path in second hunk.

> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Cc: Rob Landley <rob@landley.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>

Acked-by: Pavel Machek <pavel@ucw.cz>

(Cc-ed trivial so this does not get lost).

> @@ -326,7 +339,7 @@ Q: How can distributions ship a swsusp-supporting kernel with modular
>  disk drivers (especially SATA)?
>  
>  A: Well, it can be done, load the drivers, then do echo into
> -/sys/power/disk/resume file from initrd. Be sure not to mount
> +/sys/power/resume file from initrd. Be sure not to mount
>  anything, not even read-only mount, or you are going to lose your
>  data.
>  


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
