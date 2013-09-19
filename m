From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 Sep 2013 12:11:00 +0200
Subject: [PATCH v3 RFT 2/2] PM / Hibernate: use name_to_dev_t to parse
 resume
In-Reply-To: <1379546942-22344-3-git-send-email-sebastian.capella@linaro.org>
References: <1379546942-22344-1-git-send-email-sebastian.capella@linaro.org>
 <1379546942-22344-3-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20130919101100.GE19346@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-09-18 16:29:02, Sebastian Capella wrote:
> Use the name_to_dev_t call to parse the device name echo'd to
> to /sys/power/resume.  This imitates the method used in hibernate.c
> in software_resume, and allows the resume partition to be specified
> using other equivalent device formats as well.  By allowing
> /sys/debug/resume to accept the same syntax as the resume=device
> parameter, we can parse the resume=device in the init script and
> use the resume device directly from the kernel command line.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Cc: Len Brown <len.brown@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
